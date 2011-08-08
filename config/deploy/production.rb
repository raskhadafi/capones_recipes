set :rails_env, 'production'
set :branch, "stable"

set :deploy_to, "#{web_root}#{application}"
role :web, "web01.#{application}"                          # Your HTTP server, Apache/etc
role :app, "web01.#{application}"                          # This may be the same as your `Web` server
role :db,  "web01.#{application}", :primary => true        # This is where Rails migrations will run
