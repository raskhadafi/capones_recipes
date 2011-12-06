require 'yaml'
require 'pathname'

Capistrano::Configuration.instance.load do
  #
  # Capistrano sync.rb task for syncing databases and directories between the
  # local development environment and different multi_stage environments. You
  # cannot sync directly between two multi_stage environments, always use your
  # local machine as loop way.
  #
  # Author: Michael Kessler aka netzpirat
  # Gist:   111597
  #
  # Released under the MIT license.
  # Kindly sponsored by Screen Concept, www.screenconcept.ch
  #
  namespace :sync do
    namespace :down do

      desc <<-DESC
        Syncs database from the selected mutli_stage environement to the local develoment environment.
        The database credentials will be read from your local config/database.yml file and a copy of the
        dump will be kept within the shared sync directory. The amount of backups that will be kept is
        declared in the sync_backups variable and defaults to 5.
      DESC
      task :db, :roles => :db, :only => { :primary => true } do
        # Use production on non-multistage
        set :stage, 'production' unless exists?(:stage)

        filename = "database.#{stage}.#{Time.now.strftime '%Y-%m-%d_%H:%M:%S'}.sql.bz2"
        on_rollback { delete "#{shared_path}/sync/#{filename}" }

        # Remote DB dump
        username, password, database, host = remote_database_config(stage)
        host_option = host ? "--host='#{host}'" : ""
        run "mysqldump -u #{username} --password='#{password}' #{host_option} #{database} | bzip2 -9 > #{shared_path}/sync/#{filename}" do |channel, stream, data|
          puts data
        end
        purge_old_backups "database"

        # Download dump
        download "#{shared_path}/sync/#{filename}", filename

        # Local DB import
        username, password, database, host = database_config('development')
        run_locally "rake db:drop && rake db:create"
        run_locally "bzip2 -d -c #{filename} | mysql -u #{username} --password='#{password}' #{database}"
        run_locally "rm -f #{filename}"

        logger.important "sync database from the stage '#{stage}' to local finished"
        
        # Start db:migrate
        run_locally "rake db:migrate"
      end

    end

    namespace :up do

      desc <<-DESC
        Syncs database from the local develoment environment to the selected mutli_stage environement.
        The database credentials will be read from your local config/database.yml file and a copy of the
        dump will be kept within the shared sync directory. The amount of backups that will be kept is
        declared in the sync_backups variable and defaults to 5.
      DESC
      task :db, :roles => :db, :only => { :primary => true } do
        # Use production on non-multistage
        set :stage, 'production' unless exists?(:stage)

        filename = "database.all.#{stage}.#{Time.now.strftime '%Y-%m-%d_%H:%M:%S'}.sql.bz2"

        on_rollback do
          delete "#{shared_path}/sync/#{filename}"
          system "rm -f #{filename}"
        end

        # Make a backup before importing
        username, password, database, host = remote_database_config(stage)
        host_option = host ? "--host='#{host}'" : ""
        run "mysqldump -u #{username} --password='#{password}' #{host_option} #{database} | bzip2 -9 > #{shared_path}/sync/#{filename}" do |channel, stream, data|
          puts data
        end

        # Local DB export
        filename = "dump.local.#{Time.now.strftime '%Y-%m-%d_%H:%M:%S'}.sql.bz2"
        username, password, database, host = database_config('development')
        host_option = host ? "--host='#{host}'" : ""
        run_locally "mysqldump -u #{username} --password='#{password}' #{host_option} #{database} | bzip2 -9 > #{filename}"
        upload filename, "#{shared_path}/sync/#{filename}"
        run_locally "rm -f #{filename}"

        # Remote DB import
        username, password, database, host = remote_database_config(stage)
        host_option = host ? "--host='#{host}'" : ""
        run "bzip2 -d -c #{shared_path}/sync/#{filename} | mysql -u #{username} --password='#{password}' #{host_option} #{database}"
        run "rm -f #{shared_path}/sync/#{filename}"
        purge_old_backups "database.all"

        logger.important "sync database from local to the stage '#{stage}' finished"
      end

    end

    #
    # Reads the database credentials from the local config/database.yml file
    # +db+ the name of the environment to get the credentials for
    # Returns username, password, database
    #
    def database_config(db)
      database = YAML::load_file('config/database.yml')
      return database["#{db}"]['username'], database["#{db}"]['password'], database["#{db}"]['database'], database["#{db}"]['host']
    end

    #
    # Reads the database credentials from the remote config/database.yml file
    # +db+ the name of the environment to get the credentials for
    # Returns username, password, database
    #
    def remote_database_config(db)
      env = rails_env || db
      config = capture "cat #{deploy_to}/current/config/database.yml"
      database = YAML::load(config)
      return database["#{env}"]['username'], database["#{env}"]['password'], database["#{env}"]['database'], database["#{env}"]['host']
    end

    #
    # Returns the actual host name to sync and port
    #
    def host_and_port
      return roles[:web].servers.first.host, ssh_options[:port] || roles[:web].servers.first.port || 22
    end

  end
end
