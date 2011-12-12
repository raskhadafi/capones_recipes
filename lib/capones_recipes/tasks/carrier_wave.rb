Capistrano::Configuration.instance.load do
  before "deploy:setup", "carrier_wave:setup"
  after "deploy:finalize_update", "carrier_wave:symlink"

  namespace :carrier_wave do
    desc "Create upload directory in capistrano shared path"
    task :setup do
      run "mkdir -p #{shared_path}/uploads"
    end

    desc "Make symlink for uploads directory"
    task :symlink do
      run "ln -nfs #{shared_path}/uploads #{latest_release}/uploads"
    end
  end
end
