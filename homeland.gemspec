# coding: utf-8
Gem::Specification.new do |s|
  s.name        = "homeland"
  s.version     = "0.0.9"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jason Lee"]
  s.email       = ["huacnlee@gmail.com"]
  s.homepage    = "http://github.com/huacnlee/homeland"
  s.summary     = "A new style forum for small communitys."
  s.description = "A new style forum for small communitys."

  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency("rails", "> 3.1.0")
  s.add_dependency("jquery-atwho-rails", "~> 0.1.5")
  s.add_dependency("rails_autolink", ">= 1.0.0")

  s.files        = Dir.glob("lib/**/*") + Dir.glob("app/**/*") + Dir.glob("config/**/*") + %w(README.md Changelogs.md)
  s.require_path = 'lib'
end
