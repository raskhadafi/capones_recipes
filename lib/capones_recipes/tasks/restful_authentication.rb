Capistrano::Configuration.instance.load do
  before "deploy:setup", "restful_authentication:prepare_config"
  after "deploy:update_code", "restful_authentication:symlink"
  before "restful_authentication:configure", "deploy:update_code"

  namespace :restful_authentication do
    desc "Create shared directories"
    task :prepare_config do
      run "mkdir -p #{shared_path}/config/initializers"
    end

    desc "Make symlink for site key"
    task :symlink do
      run "ln -nfs #{shared_path}/config/initializers/site_keys.rb #{latest_release}/config/initializers/site_keys.rb"
    end

    desc "Create new site_key"
    task :configure, :roles => :app do
      run("cd #{latest_release} && /usr/bin/env bundle exec rake auth:gen:site_key RAILS_ENV=#{rails_env}")
    end
  end

  namespace :sync do
    namespace :down do
      desc "Sync down site key"
      task :restful_authentication do
        download "#{shared_path}/config/initializers/site_keys.rb", "config/initializers/site_keys.rb"
      end
    end

    namespace :up do
      desc "Sync up site key"
      task :restful_authentication do
        upload "config/initializers/site_keys.rb", "#{shared_path}/config/initializers/site_keys.rb"
      end
    end
  end
end
