require 'capistrano'
require 'capistrano/cli'
require 'capistrano_colors'

Dir.glob(File.join(File.dirname(__FILE__), '/recipes/*.rb')).sort.each { |f| load f } if Capistrano::Configuration.instance