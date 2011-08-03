# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "capones_recipes"
  gem.homepage = "http://github.com/raskhadafi/capones-recipes"
  gem.license = "MIT"
  gem.summary = "Some capistrano recipes for use." 
  gem.description = "just for fun"
  gem.email = "roman.simecek@cyt.ch"
  gem.authors = ["Roman Simecek"]
  gem.files = ['lib/recipes/*', 'lib/*', 'Capfile']
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new
