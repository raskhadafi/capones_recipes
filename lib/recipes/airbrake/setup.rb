require File.expand_path(File.dirname(__FILE__) + '/../utilities')

Capistrano::Configuration.instance(true).load do
  namespace :airbrake do
    desc "Creates the air brake initializer with the custom API key."
    task :setup do
      api_key = utilities.ask('Please insert the API key.', '')
      run "mkdir -p #{shared_path}/config/initializers"
      initializer_template = File.expand_path(File.dirname(__FILE__) + '/templates/airbrake.rb')
      utilities.init_file(initializer_template, "<%%>", api_key, "#{shared_path}/initializer/bookyt.rb")
    end
  end
end