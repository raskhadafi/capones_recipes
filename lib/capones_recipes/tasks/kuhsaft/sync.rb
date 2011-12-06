require 'yaml'
require 'pathname'

Capistrano::Configuration.instance.load do
  #
  # Capistrano sync.rb task to sync kuhsaft databas.
  #
  namespace :sync do
    namespace :down do
      namespace :kuhsaft do

        desc <<-DESC
          Syncs the database from the selected multi_stage environment
          to the local development environment.
        DESC
        task :default do
          db
        end

        desc <<-DESC
          Syncs database from the selected mutli_stage environment to the local develoment environment.
          The database credentials will be read from your local config/database.yml file and a copy of the
          dump will be kept within the shared sync directory. The amount of backups that will be kept is
          declared in the sync_backups variable and defaults to 5.
        DESC
        task :db, :roles => :db, :only => { :primary => true } do
          # Use production on non-multistage
          set :stage, 'production' unless exists?(:stage)

          filename = "database.kuhsaft.#{stage}.#{Time.now.strftime '%Y-%m-%d_%H:%M:%S'}.sql.bz2"
          on_rollback { delete "#{shared_path}/sync/#{filename}" }

          # Remote DB dump
          username, password, database, host = remote_database_config(stage)
          host_option = host ? "--host='#{host}'" : ""
          run "mysqldump -u #{username} --password='#{password}' #{host_option} #{database} pages localized_pages contents assets tags taggings | bzip2 -9 > #{shared_path}/sync/#{filename}" do |channel, stream, data|
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
        end
      end
    end

    namespace :up do
      namespace :kuhsaft do

        desc <<-DESC
          Syncs the database from the local development environment
          to the selected multi_stage environment.
        DESC
        task :default do
          db
        end

        desc <<-DESC
          Syncs database from the local develoment environment to the selected mutli_stage environement.
          The database credentials will be read from your local config/database.yml file and a copy of the
          dump will be kept within the shared sync directory. The amount of backups that will be kept is
          declared in the sync_backups variable and defaults to 5.
        DESC
        task :db, :roles => :db, :only => { :primary => true } do
          # Use production on non-multistage
          set :stage, 'production' unless exists?(:stage)

          filename = "database.kuhsaft.#{stage}.#{Time.now.strftime '%Y-%m-%d_%H:%M:%S'}.sql.bz2"

          on_rollback do
            delete "#{shared_path}/sync/#{filename}"
            run_locally "rm -f #{filename}"
          end

          # Make a backup before importing
          username, password, database, host = remote_database_config(stage)
          host_option = host ? "--host='#{host}'" : ""
          run "mysqldump -u #{username} --password='#{password}' #{host_option} #{database} pages localized_pages contents assets tags taggings | bzip2 -9 > #{shared_path}/sync/#{filename}" do |channel, stream, data|
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
          purge_old_backups "database.kuhsaft"

          logger.important "sync database from local to the stage '#{stage}' finished"
        end
      end

    end
  end
end
