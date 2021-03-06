# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sweeper_api/version"

Gem::Specification.new do |spec|
  spec.name          = "sweeper_api"
  spec.version       = SweeperAPI::VERSION
  spec.authors       = ["pseudomuto"]
  spec.email         = ["david.muto@gmail.com"]
  spec.summary       = "Needs to be updated"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/sweeperio/sweeper_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "faraday", "~> 0.9"
end
