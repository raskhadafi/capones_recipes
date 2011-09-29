require 'capistrano'
require 'capistrano/cli'
require 'capistrano_colors'

Dir.glob(File.join(File.dirname(__FILE__), '/capones_recipes/tasks/*.rb')).sort.each { |lib| require lib }
Dir.glob(File.join(File.dirname(__FILE__), '/capones_recipes/cookbook/*.rb')).sort.each { |lib| require lib }