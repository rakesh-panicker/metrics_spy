# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'metrics_spy/version'

Gem::Specification.new do |spec|
  spec.name = 'metrics_spy'
  spec.version = MetricsSpy::VERSION
  spec.authors = ["Rakesh Panicker"]
  spec.email = ["rakesh.chandran1@gmail.com"]
  spec.summary = %q{ MetricsSpy is a simple sinatra server which captures and returns fixtures for a given route }
  spec.description   = %q{This gem is useful for development where we need to capture and validate the request parameters.}
  spec.homepage      = 'https://bitbucket.org/rakesh_panicker/metrics_spy'
  spec.license       = 'MIT'
  
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables = ['metrics_spy_service']
  spec.default_executable = 'metrics_spy_service'

  spec.add_runtime_dependency "sinatra", "~> 1.4"
  spec.add_runtime_dependency "data_mapper", "~> 1.2"
  spec.add_runtime_dependency "dm-sqlite-adapter", "~> 1.2"

  spec.add_development_dependency "json_spec", "~> 1.1"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.1"

end
