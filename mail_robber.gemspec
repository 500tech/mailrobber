# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mail_robber/version'

Gem::Specification.new do |spec|
  spec.name          = "mail_robber"
  spec.version       = MailRobber::VERSION
  spec.authors       = ["Ilya Gelman"]
  spec.email         = ["ilyagelman@ilyagelman.ru"]
  spec.description   = %q{Simple email testing for Rails}
  spec.summary       = %q{Test your emails from any environment via mailrobber.com service}
  spec.homepage      = "http://mailrobber.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "launchy"
end
