Capistrano::Configuration.instance.load do
  before "deploy:setup", "db:prepare_config"
  after "deploy:finalize_update", "db:symlink"

  before "db:setup", "deploy:update_code"
  before "db:setup", "db:create"
  before "db:setup", "db:grant"
  before "db:setup", "db:configure"

  namespace :db do
    desc "Create shared directories"
    task :prepare_config, :roles => :app do
      run "mkdir -p #{shared_path}/db"
      run "mkdir -p #{shared_path}/config"
    end

    # Author::      Simone Carletti <weppos@weppos.net>
    # License::     MIT License
    # Link::        http://www.simonecarletti.com/
    # Source::      http://gist.github.com/2769
    desc <<-DESC
      Creates the database.yml configuration file in shared path.

      By default, this task uses a template unless a template
      called database.yml.erb is found either is :template_dir
      or /config/deploy folders. The default template matches
      the template for config/database.yml file shipped with Rails.
    DESC
    task :configure, :roles => :app do

      default_template = <<-EOF
      base: &base
        adapter: sqlite3
        timeout: 5000
      development:
        database: #{shared_path}/db/development.sqlite3
        <<: *base
      test:
        database: #{shared_path}/db/test.sqlite3
        <<: *base
      production:
        database: #{shared_path}/db/production.sqlite3
        <<: *base
      EOF

      location = fetch(:template_dir, "config/deploy") + '/database.yml.erb'
      template = File.file?(location) ? File.read(location) : default_template

      config = ERB.new(template)

      put config.result(binding), "#{shared_path}/config/database.yml"
    end

    desc "Make symlink for shared database yaml"
    task :symlink, :roles => :app do
      run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
    end

    task :rake, :roles => :app do
      run("cd #{latest_release} && /usr/bin/env bundle exec rake #{rake_task} RAILS_ENV=#{rails_env}")
    end

    desc "Setup database"
    task :setup, :roles => :db do
      set :rake_task, 'db:schema:load'
      rake
      set :rake_task, 'db:seed'
      rake
    end
  end
end
