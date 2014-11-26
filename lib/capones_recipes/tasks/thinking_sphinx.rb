# Thinking Sphinx for Capistrano
begin
  require 'thinking_sphinx/capistrano'
rescue LoadError
  # Support older versions of the thinking_sphinx gem (< 3.0)
  require 'thinking_sphinx/deploy/capistrano'
end

Capistrano::Configuration.instance.load do
  before "thinking_sphinx:symlink", "thinking_sphinx:setup"
  after "deploy:finalize_update", "thinking_sphinx:symlink"
  before "deploy:restart", "thinking_sphinx:configure"
  after "sync:up:db", "thinking_sphinx:rebuild"

  namespace :thinking_sphinx do
    desc "Prepare for sphinx config"
    task :setup, :roles => :app do
      run "mkdir -p #{shared_path}/config/sphinx"
      run "mkdir -p #{shared_path}/db/sphinx"
      run "mkdir -p #{shared_path}/tmp/sockets"
    end

    desc "Make symlink for sphinx configs and data"
    task :symlink, :roles => :app do
      run "ln -nfs #{shared_path}/config/sphinx #{latest_release}/config/sphinx"
      run "ln -nfs #{shared_path}/db/sphinx #{latest_release}/db/sphinx"
      run "ln -nfs #{shared_path}/tmp/sockets #{latest_release}/tmp/sockets"
    end

    desc "Rebuild index"
    task :rebuild, :roles => :app do
      run_rake "thinking_sphinx:rebuild"
    end

    def run_rake(task, options={}, &block)
      rake = fetch(:rake, "rake")
      rails_env = fetch(:rails_env, 'production')

      command = "cd #{latest_release} && #{rake} #{task} RAILS_ENV=#{rails_env} ; true"
      run(command, options, &block)
    end
  end
end
