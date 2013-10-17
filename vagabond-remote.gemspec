# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagabond/remote/version'

Gem::Specification.new do |spec|
  spec.name          = "vagabond-remote"
  spec.version       = Vagabond::Remote::VERSION
  spec.authors       = ["David Worth"]
  spec.email         = ["david.worth@mandiant.com"]
  spec.description   = %q{}
  spec.summary       = %q{}
  spec.homepage      = "https://github.org/daveworth/vagabond-remote"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rspec'
  spec.add_dependency 'vagabond-core'
  spec.add_dependency "ruby-nmap"
  spec.add_dependency "capybara-webkit"
end
