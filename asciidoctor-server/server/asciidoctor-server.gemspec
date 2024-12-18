# frozen_string_literal: true

require_relative "lib/asciidoctor-server/version"

Gem::Specification.new do |spec|
  spec.name = "asciidoctor-server"
  spec.version = Asciidoctor::Server::VERSION
  spec.authors = ["hybras"]
  spec.summary = "Run asciidoctor as a server"
  spec.license = "MIT"

  spec.required_ruby_version = ">= 2.6.0"

  spec.files = Dir.glob("**/*", File::FNM_DOTMATCH)
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "grpc-tools", "~> 1.0"
  spec.add_dependency "asciidoctor", "~> 2.0"
  spec.add_dependency "grpc", "~> 1.0"
  spec.add_dependency "logging", "~> 1.0"
  spec.add_dependency "optparse", "~> 0.3.1"
end
