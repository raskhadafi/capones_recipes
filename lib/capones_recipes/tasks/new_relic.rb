Capistrano::Configuration.instance.load do
  after "deploy:update_code", "new_relic:symlink"

  namespace :new_relic do
    desc "Creates newrelic configuration based on example"
    task :prepare_config, :roles => :app do
      upload "config/newrelic.yml.example", "#{shared_path}/config/newrelic.yml", :via => :scp
    end

    desc "Make symlink for shared application yaml"
    task :symlink, :roles => :app do
      run "ln -nfs #{shared_path}/config/newrelic.yml #{latest_release}/config/newrelic.yml"
    end
  end
end
