lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)


require 'cell/erb/version'

Gem::Specification.new do |spec|
  spec.name          = 'cells-erb'
  spec.version       = Cell::Erb::VERSION
  spec.authors       = ['Abdelkader Boudih','Nick Sutterer']
  spec.email         = %w(terminale@gmail.com apotonick@gmail.com)
  spec.summary       = 'Tilt binding for Erbse.'
  spec.description   = 'Tilt binding for Erbse. Erbse is a modern Erubis implementation with block support.'
  spec.homepage      = 'https://github.com/trailblazer/cells-erb'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency "cells", "~> 4.0.0.beta"
  spec.add_runtime_dependency "erbse", ">= 0.0.2"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end