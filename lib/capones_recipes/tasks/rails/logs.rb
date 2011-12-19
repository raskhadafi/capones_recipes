Capistrano::Configuration.instance.load do
  desc "Watch the log on the application server."
  task :watch_logs, :role => :app do
    log_file = "#{shared_path}/log/#{rails_env}.log"

    run "tail -f #{log_file}" do |channel, stream, data|
      puts data if stream == :out
      if stream == :err
        puts "[Error: #{channel[:host]}->#{rails_env}] #{data}"
        break
      end
    end
  end
end
