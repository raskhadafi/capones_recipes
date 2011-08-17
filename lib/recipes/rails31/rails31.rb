Capistrano::Configuration.instance.load do
  # Compile the assets in Rails 3.1
  after 'deploy:migrate' do
    run "cd #{release_path}; RAILS_ENV=#{rails_env} bundle exec rake assets:precompile"
  end
end
