# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minitest/same_as_it_ever_was/version'

Gem::Specification.new do |spec|
  spec.name          = 'minitest-same_as_it_ever_was'
  spec.version       = MiniTest::SameAsItEverWas::VERSION
  spec.authors       = ['Gary Gordon']
  spec.email         = ['gfgordon@gmail.com']
  spec.summary       = %q{Assert responses are consistent.}
  spec.description   = %q{Assert responses are consistent.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'minitest'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
end