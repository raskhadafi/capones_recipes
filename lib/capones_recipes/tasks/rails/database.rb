Capistrano::Configuration.instance.load do
  before "deploy:setup", "db:prepare_config"
  after "deploy:finalize_update", "db:symlink"

  namespace :db do
    desc "Create database.yaml based on example"
    task :prepare_config do
      run "mkdir -p #{shared_path}/config"
      upload "config/database.yml.example", "#{shared_path}/config/database.yml", :via => :scp
    end

    desc "Make symlink for shared database yaml"
    task :symlink do
      run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
    end

    task :rake, :roles => :app do
      run("cd #{deploy_to}/current && /usr/bin/env bundle exec rake #{rake_task} RAILS_ENV=#{rails_env}")
    end

    desc "Setup database"
    task :setup, :roles => :db do
      set :rake_task, 'db:setup'
      rake
    end
  end
end
