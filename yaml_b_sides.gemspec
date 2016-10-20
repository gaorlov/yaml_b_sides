# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yaml_b_sides/version'

Gem::Specification.new do |spec|
  spec.name          = "yaml_b_sides"
  spec.version       = YamlBSides::VERSION
  spec.authors       = ["Greg Orlov"]
  spec.email         = ["gaorlov@gmail.com"]

  spec.summary       = "A light AcriveRecord like wrapper for flat YAML files"
  spec.description   = "An ActiveRecord-like interface for reading from & queryeing flat yaml files"
  spec.homepage      = "http://github.com/gaorlov/yaml_b_sides"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "activemodel"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "m"
end
