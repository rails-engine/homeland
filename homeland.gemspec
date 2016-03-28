$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "homeland/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "homeland"
  s.version     = Homeland::VERSION
  s.authors     = ["Jason Lee"]
  s.email       = ["huacnlee@gmail.com"]
  s.homepage    = "https://github.com/rails-engine/homeland"
  s.summary     = "A new style forum for small communitys."
  s.description = "A new style forum for tiny community as Rails Engine. You can mount this in you apps."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency 'rails', '>= 4.2.0', '<= 5.1.0'
  s.add_dependency 'activerecord', '>= 4.2.0', "<= 5.1.0"
  s.add_dependency 'redcarpet', '>= 3.3.0'
  s.add_dependency 'will_paginate', '>= 3.0.0'
  s.add_dependency 'jquery-rails', '>= 4.0.0', '<= 5.1.0'
  s.add_dependency 'font-awesome-rails', ">= 4.4.0.0"
end
