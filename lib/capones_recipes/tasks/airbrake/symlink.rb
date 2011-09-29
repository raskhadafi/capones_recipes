Capistrano::Configuration.instance(true).load do
  before "deploy:migrate", "airbrake:symlink"
  
  namespace :airbrake do
    desc "Sets the symlink to shared/config/initializers/airbrake.rb"
    task :symlink do
      run "ln -nfs #{shared_path}/config/initializers/airbrake.rb #{release_path}/config/initializers/airbrake.rb"
    end
  end
end