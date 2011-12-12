# Email configuration
Capistrano::Configuration.instance.load do
  after "deploy:finalize_update", "email:symlink"
  
  namespace :email do
    desc "Make symlink for email config"
    task :symlink, :roles => :app do
      run "ln -nfs #{shared_path}/config/initializers/email.rb #{latest_release}/config/initializers/email.rb"
    end
  end
end
