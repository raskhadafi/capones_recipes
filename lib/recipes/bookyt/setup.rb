Capistrano::Configuration.instance.load do
  after "deploy:setup", "bookyt:setup"
  before "deploy:migrate", "bookyt:symlink"

  namespace :bookyt do
    desc "Asks which modules should be initialized and writes the config/initializer/bookyt.rb"
    task :setup, :roles => :app do
      run "mkdir -p #{shared_path}/initializer"
      # TODO: From here capistrano should ask which modules should be initialized and write the initializer.
    end
    
    desc "Make symlink for shared bookyt initializer"
    task :symlink do
      run "ln -nfs #{shared_path}/initializer/bookyt.rb #{release_path}/initializer/bookyt.rb"
    end
  end
end
