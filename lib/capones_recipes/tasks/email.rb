# Email configuration
Capistrano::Configuration.instance.load do
  after "deploy:finalize_update", "email:symlink"
  
  namespace :email do
    desc "Make symlink for email config"
    task :symlink, :roles => :app do
      run "ln -nfs #{shared_path}/config/initializers/email.rb #{release_path}/config/initializers/email.rb"
    end
  end
end
