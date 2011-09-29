Capistrano::Configuration.instance.load do
  before "deploy:setup", "restful_authentication:setup"
  after "deploy:update_code", "restful_authentication:symlink"

  namespace :restful_authentication do
    desc "Create site_keys in capistrano shared path"
    task :setup do
      run "mkdir -p #{shared_path}/config/initializers"
    end

    desc "Make symlink for shared uploads"
    task :symlink do
      run "ln -nfs #{shared_path}/config/initializers/site_keys.rb #{release_path}/config/initializers/site_keys.rb"
    end
  end
end
