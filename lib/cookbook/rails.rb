require 'capistrano'
require 'capistrano/cli'
require 'capistrano_colors'
# Passenger
require 'cap_recipes/tasks/passenger'

load File.join(File.dirname(__FILE__), '../recipes/rails.rb')
