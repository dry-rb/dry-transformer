# frozen_string_literal: true

# this file is synced from dry-rb/template-gem project

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dry/transformer/version"

Gem::Specification.new do |spec|
  spec.name          = "dry-transformer"
  spec.authors       = ["Piotr Solnica"]
  spec.email         = ["piotr.solnica@gmail.com"]
  spec.license       = "MIT"
  spec.version       = Dry::Transformer::VERSION.dup

  spec.summary       = "Data transformation toolkit"
  spec.description   = spec.summary
  spec.homepage      = "https://dry-rb.org/gems/dry-transformer"
  spec.files         = Dir["CHANGELOG.md", "LICENSE", "README.md", "dry-transformer.gemspec", "lib/**/*"]
  spec.bindir        = "bin"
  spec.executables   = []
  spec.require_paths = ["lib"]

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["changelog_uri"]     = "https://github.com/dry-rb/dry-transformer/blob/main/CHANGELOG.md"
  spec.metadata["source_code_uri"]   = "https://github.com/dry-rb/dry-transformer"
  spec.metadata["bug_tracker_uri"]   = "https://github.com/dry-rb/dry-transformer/issues"

  spec.required_ruby_version = ">= 2.7.0"

  # to update dependencies edit project.yml
  spec.add_runtime_dependency "zeitwerk", "~> 2.6"

end
