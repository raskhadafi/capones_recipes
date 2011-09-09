require File.expand_path(File.dirname(__FILE__) + '/../utilities')

Capistrano::Configuration.instance(true).load do
  after "deploy:setup", "bookyt:setup"
  before "deploy:migrate", "bookyt:symlink"

  namespace :bookyt do
    desc "Asks which modules should be initialized and writes the config/initializer/bookyt.rb"
    task :setup, :roles => :app do
      run "mkdir -p #{shared_path}/initializer"
      
      modules = [:pos, :salary, :stock, :projects].inject([]) do |out, pos|
        out << "bookyt_#{pos.to_s}" #if utilities.yes? "Install bookyt_#{pos.to_s}"
        
        out
      end
      modules = modules.map {|item| "'#{item}'" }.join(', ')
      initializer_template = File.expand_path(File.dirname(__FILE__) + '/templates/bookyt.rb')
      utilities.init_file(initializer_template, "<%%>", modules, "#{shared_path}/initializer/bookyt.rb")
    end
    
    desc "Make symlink for shared bookyt initializer"
    task :symlink do
      run "ln -nfs #{shared_path}/initializer/bookyt.rb #{release_path}/initializer/bookyt.rb"
    end
  end
end
