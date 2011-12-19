Capistrano::Configuration.instance.load do
  #
  # Capistrano task for syncing directories.
  #
  namespace :sync do
    after "deploy:finalize_update", "sync:symlink"
    after "sync:up:fs", "sync:symlink"
    
    desc "Sets the symlink to sync directories"
    task :symlink, :roles => :app do
      Array(fetch(:sync_directories, [])).each do |syncdir|
        unless File.directory? "#{syncdir}"
          logger.info "Create '#{syncdir}' directory"
          run "mkdir -p #{shared_path}/#{syncdir}"
        end
        
        run "ln -nfs #{shared_path}/#{syncdir} #{latest_release}/#{syncdir}"
      end
    end
  end
end
