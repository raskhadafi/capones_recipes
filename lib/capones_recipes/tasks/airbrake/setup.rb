require File.expand_path(File.dirname(__FILE__) + '/../utilities')

Capistrano::Configuration.instance.load do
  namespace :airbrake do
    desc "Creates the air brake initializer with the custom API key."
    task :prepare_config, :roles => :app do
      api_key = Utilities.ask('Please insert the API key.', '')
      initializer_template = File.expand_path(File.dirname(__FILE__) + '/templates/airbrake.rb')
      put Utilities.init_file(initializer_template, "<%%>", api_key), "#{shared_path}/config/initializers/airbrake.rb"
    end
  end
end
