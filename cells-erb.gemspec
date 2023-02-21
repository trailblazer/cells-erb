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

  spec.metadata['bug_tracker_uri'] = "#{spec.homepage}/issues"
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/HEAD/CHANGES.md"
  spec.metadata['documentation_uri'] = "https://www.rubydoc.info/gems/cells-erb/#{spec.version}"
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |file|
      file.start_with?(*%w[.git .travis Gemfile Rakefile test])
    end
  end
  spec.require_paths = ['lib']

  spec.add_dependency "cells", "~> 4.0"
  spec.add_dependency "erbse", ">= 0.1.1"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
