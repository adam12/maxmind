require File.expand_path('../lib/maxmind/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_runtime_dependency 'activesupport', '~> 3.2.2'

  gem.add_development_dependency 'rspec', '~> 2.9.0'
  gem.add_development_dependency 'mocha', '~> 0.10.5'

  gem.name = 'maxmind-rb'
  gem.summary = "A wrapper around MaxMind's minFraud anti-fraud service."
  gem.version = Maxmind::VERSION.dup
  gem.authors = ['Tom Blomfield', 'Adam Daniels', 'Tinu Cleatus', 't.e.morgan']
  gem.email = ['tom@gocardless.com']
  gem.homepage = 'https://github.com/tomblomfield/maxmind'
  gem.require_paths = ['lib']
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- spec/*`.split("\n")
end