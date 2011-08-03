# Compile the assets in Rails 3.1
after 'deploy:migrate' do
  run "cd #{release_path}; RAILS_ENV=production rake assets:precompile"
end