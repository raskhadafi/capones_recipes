Capistrano::Configuration.instance.load do
  after "deploy:update_code", "restful_authentication:symlink"

  namespace :restful_authentication do
    desc "Make symlink for shared uploads"
    task :symlink do
      run "ln -nfs #{shared_path}/config/initializers/site_keys.rb #{latest_release}/config/initializers/site_keys.rb"
    end
  end
end
