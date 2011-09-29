require 'capistrano'
require 'capistrano/cli'
require 'capistrano_colors'
# Passenger
require 'cap_recipes/tasks/passenger'

require File.join(File.dirname(__FILE__), '../tasks/rails.rb')
require File.join(File.dirname(__FILE__), '../tasks/database/mysql.rb')
require File.join(File.dirname(__FILE__), '../tasks/database/sync.rb')
