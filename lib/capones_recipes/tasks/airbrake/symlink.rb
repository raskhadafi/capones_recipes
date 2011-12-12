Capistrano::Configuration.instance(true).load do
  after "deploy:finalize_update", "airbrake:symlink"
  
  namespace :airbrake do
    desc "Sets the symlink to shared/config/initializers/airbrake.rb"
    task :symlink do
      run "ln -nfs #{shared_path}/config/initializers/airbrake.rb #{latest_release}/config/initializers/airbrake.rb"
    end
  end
end
