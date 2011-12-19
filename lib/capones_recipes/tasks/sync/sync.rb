Capistrano::Configuration.instance.load do
  #
  # Capistrano task for syncing data between the
  # local development environment and different multi_stage environments. You
  # cannot sync directly between two multi_stage environments, always use your
  # local machine as loop way.
  #
  # Based on code by Michael Kessler aka netzpirat, sponsored by Screen Concept, www.screenconcept.ch
  #
  # Released under the MIT license.
  #
  namespace :sync do
    after "deploy:setup", "sync:setup"

    desc <<-DESC
      Creates the sync dir in shared path. The sync directory is used to keep
      backups of database dumps and archives from synced directories. This task will
      be called on 'deploy:setup'
    DESC
    task :setup, :roles => :app do
      run "mkdir -p #{shared_path}/sync"
    end

    namespace :down do
      desc <<-DESC
        Syncs data from the selected multi_stage environment to the local development environment.
        This task calls all tasks in the 'sync:down' namespace.
      DESC
      task :default do
        subtasks = task_list(true) - [current_task]
        subtasks.map{|task| execute_task(task)}
      end
    end

    namespace :up do
      desc <<-DESC
        Syncs data from the local development environment to the selected multi_stage environment.
        This task calls all tasks in the 'sync:up' namespace.
      DESC
      task :default do
        subtasks = task_list(true) - [current_task]
        subtasks.map{|task| execute_task(task)}
      end
    end

    #
    # Purge old backups within the shared sync directory
    #
    def purge_old_backups(base)
      count = fetch(:sync_backups, 5).to_i
      backup_files = capture("ls -xt #{shared_path}/sync/#{base}*").split.reverse
      if count >= backup_files.length
        logger.important "no old backups to clean up"
      else
        logger.info "keeping #{count} of #{backup_files.length} sync backups"
        delete_backups = (backup_files - backup_files.last(count)).join(" ")
        try_sudo "rm -rf #{delete_backups}"
      end
    end
  end
end
