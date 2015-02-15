# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'cells-erb'
  spec.version       = '0.0.1'
  spec.authors       = ['Abdelkader Boudih','Nick Sutterer']
  spec.email         = %w(terminale@gmail.com apotonick@gmail.com)
  spec.summary       = 'Add block support to Erubis for cells 4'
  spec.description   = 'Add block support to Erubis for cells 4
'
  spec.homepage      = 'https://github.com/trailblazer/cells-erb'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'cells', '~> 4.0.0.beta'
  spec.add_runtime_dependency 'erubis', '~> 2.7.0'
  spec.add_development_dependency 'bundler', '>= 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
