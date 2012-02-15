# Code snippet from: https://raw.github.com/codesnik/rails-recipes/master/lib/rails-recipes/console.rb

Capistrano::Configuration.instance.load do
  desc "script/console on a remote server"
  task :console do
    rails_env = fetch(:rails_env, "production")
    server = find_servers(:roles => [:app]).first
    run_with_tty server, %W( script/console #{rails_env} )
  end

  desc "script/dbconsole on a remote server"
  task :dbconsole do 
    rails_env = fetch(:rails_env, "production")
    server = find_servers(:roles => [:app]).first
    run_with_tty server, %W( script/dbconsole #{rails_env} )
  end

  def run_with_tty server, cmd
    # looks like total pizdets
    command = []
    command += %W( ssh -t #{gateway} -l #{self[:gateway_user] || self[:user]} ) if self[:gateway]
    command += %W( ssh -t )
    command += %W( -p #{server.port}) if server.port
    command += %W( -l #{user} #{server.host} )
    command += %W( cd #{current_path} )
    # have to escape this once if running via double ssh
    command += [self[:gateway] ? '\&\&' : '&&']
    command += Array(cmd)
    system *command
  end
end
