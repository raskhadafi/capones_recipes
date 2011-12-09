Capistrano::Configuration.instance.load do
  after "deploy:update_code", "restful_authentication:symlink"

  namespace :restful_authentication do
    desc "Make symlink for site key"
    task :symlink do
      run "ln -nfs #{shared_path}/config/initializers/site_keys.rb #{release_path}/config/initializers/site_keys.rb"
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
