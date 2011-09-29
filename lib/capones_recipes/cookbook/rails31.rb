require 'capistrano'
require 'capistrano/cli'
require 'capistrano_colors'
# Passenger
require 'cap_recipes/tasks/passenger'

load File.join(File.dirname(__FILE__), '../tasks/rails.rb')
load File.join(File.dirname(__FILE__), '../tasks/rails31.rb')
