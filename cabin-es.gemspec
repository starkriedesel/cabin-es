# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cabin/es/version'

Gem::Specification.new do |spec|
  spec.name          = "cabin-es"
  spec.version       = Cabin::Es::VERSION
  spec.authors       = ["Stark Riedesel"]
  spec.email         = ["starkriedesel@gmail.com"]

  spec.summary       = %q{Cabin output support for ElasticSearch}
  spec.description   = %q{Add support for cabin logs to be forwarded to ElasticSearch.}
  spec.homepage      = "https://www.github.com/starkriedesel"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://findthe.ninja'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = []
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "cabin", "~> 0.9.0"
  spec.add_runtime_dependency "elasticsearch", "~> 2.0.0"
end
