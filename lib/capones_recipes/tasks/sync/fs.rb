Capistrano::Configuration.instance.load do
  #
  # Capistrano task for syncing directories.
  #
  namespace :sync do
    namespace :down do
      desc <<-DESC
        Sync declared directories from the selected multi_stage environment to the local development
        environment. The synced directories must be declared as an array of Strings with the sync_directories
        variable. The path is relative to the shared path.
      DESC
      task :fs, :roles => :web, :once => true do
        # Use production on non-multistage
        set :stage, 'production' unless exists?(:stage)

        server, port = host_and_port

        Array(fetch(:sync_directories, [])).each do |syncdir|
          unless File.directory? "#{syncdir}"
            logger.info "create local '#{syncdir}' folder"
            Dir.mkdir "#{syncdir}"
          end
          logger.info "sync #{syncdir} from #{server}:#{port} to local"
          destination, base = Pathname.new(syncdir).split
          run_locally "rsync --verbose --archive --compress --copy-links --delete --stats --rsh='ssh -p #{port}' #{user}@#{server}:#{shared_path}/#{syncdir} #{destination.to_s}"
        end

        logger.important "sync filesystem from the stage '#{stage}' to local finished"
      end
    end

    namespace :up do
      desc <<-DESC
        Sync declared directories from the local development environement to the selected multi_stage
        environment. The synced directories must be declared as an array of Strings with the sync_directories
        variable.  The path is relative to the shared path.
      DESC
      task :fs, :roles => :web, :once => true do
        # Use production on non-multistage
        set :stage, 'production' unless exists?(:stage)

        server, port = host_and_port
        Array(fetch(:sync_directories, [])).each do |syncdir|
          destination, base = Pathname.new(syncdir).split

          unless File.directory? "#{syncdir}"
            logger.info "Create '#{syncdir}' directory"
            run "mkdir -p #{shared_path}/#{syncdir}"
          end

          # Make a backup
          logger.info "backup #{syncdir}"
          run "tar cjf #{shared_path}/sync/#{base}.#{Time.now.strftime '%Y-%m-%d_%H:%M:%S'}.tar.bz2 #{shared_path}/#{syncdir}"
          purge_old_backups "#{base}"

          # Sync directory up
          logger.info "sync #{syncdir} to #{server}:#{port} from local"
          run_locally "rsync --verbose --archive --compress --keep-dirlinks --delete --stats --rsh='ssh -p #{port}' #{syncdir} #{user}@#{server}:#{shared_path}/#{destination.to_s}"
        end
        logger.important "sync filesystem from local to the stage '#{stage}' finished"
      end
    end

    #
    # Returns the actual host name to sync and port
    #
    def host_and_port
      return roles[:web].servers.first.host, ssh_options[:port] || roles[:web].servers.first.port || 22
    end
  end
end
