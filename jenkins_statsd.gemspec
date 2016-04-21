# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jenkins_statsd/version'

Gem::Specification.new do |spec|
  spec.name          = "jenkins_statsd"
  spec.version       = JenkinsStatsd::VERSION
  spec.authors       = ["Matt Chun-Lum"]

  spec.summary       = %q{Collect jenkins metrics and send to statsd}
  spec.description   =
    %q{Collect jenkins metrics and send to statsd (depends on having the metrics plugin installed on jenkins instance)}
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "eventmachine"
  spec.add_dependency "rest-client"
  spec.add_dependency "semantic_logger"
  spec.add_dependency "statsd-ruby"
  spec.add_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
