# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rack/analytics/version"

Gem::Specification.new do |s|
  s.name        = "rack-analytics"
  s.version     = Rack::Analytics::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Cainã Costa"]
  s.email       = ["cainan.costa@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/rack-analytics"
  s.summary     = %q{A rack middleware that collects access statistics}
  s.description = %q{A rack middleware that collects access statistics and saves them on a MongoDB database.}

  s.rubyforge_project = "rack-analytics"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency('rack')
  s.add_runtime_dependency('bson_ext')
  s.add_runtime_dependency('mongo')
  s.add_runtime_dependency('activesupport')

  s.add_development_dependency('rake')
  s.add_development_dependency('riot')
  s.add_development_dependency('sinatra')
  s.add_development_dependency('rack-test')
  s.add_development_dependency('watchr')
end
