set :rails_env, 'staging'
set :branch, "master"

set :deploy_to, "#{web_root}#{application}"
role :web, "test.#{application}"                          # Your HTTP server, Apache/etc
role :app, "test.#{application}"                          # This may be the same as your `Web` server
role :db,  "test.#{application}", :primary => true        # This is where Rails migrations will run
