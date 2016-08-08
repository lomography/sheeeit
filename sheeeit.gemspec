# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sheeeit/version'

Gem::Specification.new do |spec|
  spec.name          = "sheeeit"
  spec.version       = Sheeeit::VERSION
  spec.authors       = ["Martin Sereinig"]
  spec.email         = ["srecnig@fsinf.at"]

  spec.summary       = "Writes data into a Google Docs spreadsheet"
  spec.description   = "Expects rows of a spreadsheet as arrays. Will then write those to a preconfigured spreadsheet in Google Docs."
  spec.homepage      = "http://www.github.com/lomography/sheeeit"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '~> 2.2'

  spec.add_dependency "google_drive", "~> 2.0.0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "byebug"
end
