# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rolling_timeout/version'

Gem::Specification.new do |spec|
	spec.name          = "rolling_timeout"
	spec.version       = RollingTimeout::VERSION
	spec.authors       = ["Will Jessop"]
	spec.email         = ["will@willj.net"]
	spec.description   = %q{a timeout with a rolling window that can be moved forward}
	spec.summary       = %q{a timeout with a rolling window that can be moved forward}
	spec.homepage      = "https://github.com/wjessop/rolling_timeout"
	spec.license       = "MIT"

	spec.files         = `git ls-files`.split($/)
	spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
	spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
	spec.require_paths = ["lib"]

	spec.add_development_dependency "bundler", "~> 1.3"
	spec.add_development_dependency "rake"
	spec.add_development_dependency "minitest"
end
