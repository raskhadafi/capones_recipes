Capistrano::Configuration.instance.load do
  before "deploy:finalize_update", "settings_logic:symlink"

  namespace :settings_logic do
    desc "Make symlink for shared application yaml"
    task :symlink, :roles => :app do
      run "ln -nfs #{shared_path}/config/application.yml #{latest_release}/config/application.yml"
    end
  end
end
