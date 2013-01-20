# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'maxmind/version'

Gem::Specification.new do |s|
  s.name = "maxmind"
  s.version = Maxmind::VERSION

  s.authors = ["Adam Daniels", "Tinu Cleatus", "t.e.morgan", "Sam Oliver"]
  s.date = "2012-01-06"
  s.description = "A wrapper around MaxMind's minFraud anti-fraud service. \n\nhttp://www.maxmind.com/app/ccv_overview\n"
  s.email = "adam@mediadrive.ca"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.homepage = "http://github.com/adam12/maxmind"
  s.require_paths = ["lib"]
  s.summary = "Wrapper for MaxMind's minFraud service"

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'webmock'
end
