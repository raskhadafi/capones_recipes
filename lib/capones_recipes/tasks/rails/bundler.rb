Capistrano::Configuration.instance.load do
  # Bundle install
  require "bundler/capistrano"
  after "deploy:update_code", "bundle:install"
end