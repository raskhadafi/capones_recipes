Capistrano::Configuration.instance.load do
  before "deploy:setup", "kuhsaft:setup"
  after "deploy:update_code", "kuhsaft:symlink"

  namespace :kuhsaft do
    desc "Create uploads directory in capistrano shared path"
    task :setup do
      run "mkdir -p #{shared_path}/uploads"
    end

    desc "Make symlink for shared uploads"
    task :symlink do
      run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
    end
  end
end
