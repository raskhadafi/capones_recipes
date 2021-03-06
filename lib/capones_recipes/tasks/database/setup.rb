Capistrano::Configuration.instance.load do
  namespace :db do
    desc "Create database and grant permissions"
    task :create, :roles => :db_server do
      run "mysqladmin -u root -p create #{db_database} || true" do |channel, stream, data|
        if data =~ /^Enter password:/
          logger.info "#{channel[:host]} asked for password"
          channel.send_data "\n"
        else
          logger.info data
        end
      end
    end

    desc "Grant access"
    task :grant, :roles => :db_server do
      # TODO: support more than one server
      web_server = find_servers(:roles => :app).first
      # lookup fqdn for web servers
      fqdn_web_server = `host -N 2 #{web_server} | cut -f 1 -d ' '`.delete("\n")
      run "mysql -u root -p #{db_database} -e \"GRANT ALL PRIVILEGES ON #{db_database}.* TO '#{db_username}'@'#{fqdn_web_server}' IDENTIFIED BY '#{db_password}'\"" do |channel, stream, data|
        if data =~ /^Enter password:/
          logger.info "#{channel[:host]} asked for password"
          channel.send_data "\n"
        else
          logger.info data
        end
      end
    end
  end
end
