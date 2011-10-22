# -*- encoding: utf-8 -*-

$:.unshift File.expand_path('../lib', __FILE__)
require 'capones_recipes/version'

Gem::Specification.new do |s|
  # Description
  s.name         = "capones_recipes"
  s.version      = CaponesRecipes::VERSION
  s.summary      = "Some capistrano recipes for use."
  s.description  = "A collection of usefull capistrano recipes used by CyT GmbH and others."

  s.homepage     = "http://github.com/raskhadafi/capones-recipes"
  s.authors      = ["Roman Simecek (CyT)", "Simon Hürlimann (CyT)"]
  s.email        = ["roman.simecek@cyt.ch", "simon.huerlimann@cyt.ch"]
  s.licenses     = ["MIT"]

  # Files
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files        = `git ls-files`.split("\n")

  s.require_paths = ["lib"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capistrano>, [">= 0"])
      s.add_runtime_dependency(%q<capistrano_colors>, [">= 0"])
      s.add_runtime_dependency(%q<cap-recipes>, [">= 0"])
      s.add_runtime_dependency(%q<capistrano-ext>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<capistrano>, [">= 0"])
      s.add_dependency(%q<capistrano_colors>, [">= 0"])
      s.add_dependency(%q<cap-recipes>, [">= 0"])
      s.add_dependency(%q<capistrano-ext>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<capistrano>, [">= 0"])
    s.add_dependency(%q<capistrano_colors>, [">= 0"])
    s.add_dependency(%q<cap-recipes>, [">= 0"])
    s.add_dependency(%q<capistrano-ext>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end
