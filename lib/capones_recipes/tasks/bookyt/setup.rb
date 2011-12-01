require File.expand_path(File.dirname(__FILE__) + '/../utilities')

Capistrano::Configuration.instance(true).load do
  after "deploy:finalize_update", "bookyt:symlink"

  namespace :bookyt do
    desc "Interactive configuration"
    task :prepare_config, :roles => :app do
      modules = [:pos, :salary, :stock, :projects].inject([]) do |out, pos|
        out << "bookyt_#{pos.to_s}" if Utilities.yes? "Install bookyt_#{pos.to_s}"
        
        out
      end
      modules = modules.map {|item| "'#{item}'" }.join(', ')
      initializer_template = File.expand_path(File.dirname(__FILE__) + '/templates/bookyt.rb')
      puts Utilities.init_file(initializer_template, "<%%>", modules), "#{shared_path}/initializer/bookyt.rb"
    end
    
    desc "Make symlink for shared bookyt initializer"
    task :symlink do
      run "ln -nfs #{shared_path}/initializer/bookyt.rb #{release_path}/initializer/bookyt.rb"
    end
  end
end
