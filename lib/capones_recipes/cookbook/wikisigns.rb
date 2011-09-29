require 'capistrano'
require 'capistrano/cli'
require 'capistrano_colors'
# Passenger
require 'cap_recipes/tasks/passenger'

load File.join(File.dirname(__FILE__), '../tasks/rails.rb')
load File.join(File.dirname(__FILE__), '../tasks/settings_logic.rb')
load File.join(File.dirname(__FILE__), '../tasks/new_relic.rb')
load File.join(File.dirname(__FILE__), '../tasks/database/mysql.rb')
load File.join(File.dirname(__FILE__), '../tasks/database/sync.rb')
