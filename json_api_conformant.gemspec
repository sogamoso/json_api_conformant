# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'json_api_conformant/version'

Gem::Specification.new do |spec|
  spec.name          = "json_api_conformant"
  spec.version       = JSON::API::Conformant::VERSION
  spec.authors       = ["Sebastian Sogamoso"]
  spec.email         = ["sebasoga@gmail.com"]
  spec.summary       = %q{Ruby JSON API validator.}
  spec.description   = %q{Interface for validating JSON objects against a JSON API schema.}
  spec.homepage      = "https://github.com/sebasoga/json_api_conformant"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "json-schema", "~> 2.2"
end
