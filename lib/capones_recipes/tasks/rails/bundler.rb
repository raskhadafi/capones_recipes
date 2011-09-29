Capistrano::Configuration.instance.load do
  # Bundle install
  require "bundler/capistrano"
  after "bundle:install", "deploy:migrate"
end