Capistrano::Configuration.instance.load do
  before "db:symlink", "settings_logic:symlink"

  namespace :settings_logic do
    desc "Create application yaml in capistrano shared path"
    task :prepare_config do
      run "mkdir -p #{shared_path}/config"
      upload "config/application.yml.example", "#{shared_path}/config/application.yml", :via => :scp
    end

    desc "Make symlink for shared application yaml"
    task :symlink do
      run "ln -nfs #{shared_path}/config/application.yml #{latest_release}/config/application.yml"
    end
  end
end
