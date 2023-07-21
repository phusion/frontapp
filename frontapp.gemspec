lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "frontapp/version"

Gem::Specification.new do |s|
  s.name        = 'frontapp'
  s.version     = Frontapp::VERSION
  s.date        = '2018-10-15'
  s.summary     = "Ruby client for Frontapp API"
  s.description = "Ruby client for Frontapp API"
  s.authors     = ["Niels van der Zanden"]
  s.email       = 'niels@phusion.nl'
  s.files       = ["lib/frontapp.rb", "lib/frontapp/client.rb", "lib/frontapp/error.rb", "lib/frontapp/version.rb"]
  s.files       += Dir.glob("lib/frontapp/client/*.rb")
  s.files       += Dir.glob("lib/frontapp/utils/*.rb")
  s.homepage    = 'https://github.com/phusion/frontapp'
  s.license     = 'MIT'
  s.add_dependency 'http', '>= 5'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'rake'
end
