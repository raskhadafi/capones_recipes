# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{capones_recipes}
  s.version = "0.10.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Roman Simecek", "Simon Hürlimann"]
  s.date = %q{2011-08-17}
  s.description = %q{A collection of useful capistrano recipes used by CyT GmbH and others.}
  s.email = %q{roman.simecek@cyt.ch}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Capfile",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "capones_recipes.gemspec",
    "config/deploy.rb",
    "config/deploy/production.rb",
    "config/deploy/staging.rb",
    "lib/capones_recipes.rb",
    "lib/cookbook/rails.rb",
    "lib/cookbook/rails31.rb",
    "lib/cookbook/wikisigns.rb",
    "lib/recipes/database.rb",
    "lib/recipes/database/mysql.rb",
    "lib/recipes/database/sqlite.rb",
    "lib/recipes/database/sync.rb",
    "lib/recipes/katalog.rb",
    "lib/recipes/katalog/import.rb",
    "lib/recipes/katalog/katalog.rb",
    "lib/recipes/kuhsaft.rb",
    "lib/recipes/kuhsaft/setup.rb",
    "lib/recipes/new_relic.rb",
    "lib/recipes/new_relic/new_relic.rb",
    "lib/recipes/rails.rb",
    "lib/recipes/rails/bundler.rb",
    "lib/recipes/rails/database_yml.rb",
    "lib/recipes/rails/mod_rails.rb",
    "lib/recipes/rails31.rb",
    "lib/recipes/rails31/rails31.rb",
    "lib/recipes/settings_logic.rb",
    "lib/recipes/settings_logic/settings_logic.rb",
    "lib/recipes/thinking_sphinx.rb",
    "lib/recipes/thinking_sphinx/thinking_sphinx.rb"
  ]
  s.homepage = %q{http://github.com/raskhadafi/capones-recipes}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Some capistrano recipes for use.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capistrano>, [">= 0"])
      s.add_runtime_dependency(%q<capistrano_colors>, [">= 0"])
      s.add_runtime_dependency(%q<cap-recipes>, [">= 0"])
      s.add_runtime_dependency(%q<capistrano-ext>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.1"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<capistrano>, [">= 0"])
      s.add_dependency(%q<capistrano_colors>, [">= 0"])
      s.add_dependency(%q<cap-recipes>, [">= 0"])
      s.add_dependency(%q<capistrano-ext>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.1"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<capistrano>, [">= 0"])
    s.add_dependency(%q<capistrano_colors>, [">= 0"])
    s.add_dependency(%q<cap-recipes>, [">= 0"])
    s.add_dependency(%q<capistrano-ext>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.1"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

