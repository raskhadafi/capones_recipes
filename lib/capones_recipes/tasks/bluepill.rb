Capistrano::Configuration.instance.load do
  namespace :deploy do
    task :start, :roles => :app, :except => { :no_release => true } do
      run "bluepill --no-privileged #{instance} start"
    end

    task :stop, :roles => :app, :except => { :no_release => true } do
      run "bluepill --no-privileged #{instance} stop"
    end

    task :restart, :roles => :app, :except => { :no_release => true } do
      run "bluepill --no-privileged #{instance} restart"
    end
  end

  before "deploy:setup", "bluepill:configure"

  namespace :bluepill do
    desc "Create bluepill recipe"
    task :configure, :roles => [:app], :except => { :no_release => true } do
      #{shared_path}
      location = fetch(:template_dir, "config/deploy") + '/bluepill.rb.erb'
      template = File.read(location)
      config = ERB.new(template)

      put config.result(binding), "#{shared_path}/config/bluepill.rb"
    end

    desc "Load bluepill recipe"
    task :setup, :roles => [:app], :except => { :no_release => true } do
      run "bluepill --no-privileged load #{shared_path}/config/bluepill.rb"
    end

    desc "Prints bluepills monitored processes statuses"
    task :status, :roles => [:app] do
      run "bluepill --no-privileged #{instance} status"
    end
  end
end

