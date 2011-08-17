require 'capistrano'
require 'capistrano/cli'
require 'capistrano_colors'
# Passenger
require 'cap_recipes/tasks/passenger'

load File.join(File.dirname(__FILE__), '../recipes/rails.rb')
load File.join(File.dirname(__FILE__), '../recipes/settings_logic.rb')
load File.join(File.dirname(__FILE__), '../recipes/new_relic.rb')
load File.join(File.dirname(__FILE__), '../recipes/database/mysql.rb')
load File.join(File.dirname(__FILE__), '../recipes/database/sync.rb')
