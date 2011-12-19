# Email configuration
Capistrano::Configuration.instance.load do
  before "deploy:setup", "db:prepare_config"
  after "deploy:finalize_update", "email:symlink"
  
  namespace :email do
    desc "Create shared directories"
    task :prepare_config, :roles => :app do
      run "mkdir -p #{shared_path}/config/initializers"
    end

    desc "Configure email.yml"
    task :configure, :roles => :app do
      default_template = <<-EOF
      ActionMailer::Base.delivery_method = :sendmail
      EOF

      location = fetch(:template_dir, "config/deploy") + '/email.rb.erb'
      template = File.file?(location) ? File.read(location) : default_template

      config = ERB.new(template)

      put config.result(binding), "#{shared_path}/config/initializers/email.rb"
    end

    desc "Make symlink for email config"
    task :symlink, :roles => :app do
      run "ln -nfs #{shared_path}/config/initializers/email.rb #{latest_release}/config/initializers/email.rb"
    end
  end
end
