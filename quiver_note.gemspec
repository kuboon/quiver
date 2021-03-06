# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quiver_note/version'

Gem::Specification.new do |spec|
  spec.name          = "quiver_note"
  spec.version       = Quiver::VERSION
  spec.authors       = ["kuboon"]
  spec.email         = ["kuboon@trick-with.net"]
  spec.summary       = %q{Unofficial ruby interface for [HappenApps quiver](http://happenapps.com/#quiver)}
#  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = "https://github.com/kuboon/quiver"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "> 3.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
