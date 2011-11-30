require 'capistrano'
require 'capistrano/cli'
require 'capistrano_colors'

# Multistaging
require 'capistrano/ext/multistage'

# Passenger
require 'cap_recipes/tasks/passenger'

# Bundler
require "bundler/capistrano"

require File.join(File.dirname(__FILE__), '../tasks/rails.rb')
require File.join(File.dirname(__FILE__), '../tasks/database/mysql.rb')
require File.join(File.dirname(__FILE__), '../tasks/database/sync.rb')
