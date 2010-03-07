require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "maxmind-rb"
    gem.summary = "Wrapper for MaxMind's minFraud service"
    gem.description = <<-EOF
A wrapper around MaxMind's minFraud anti-fraud service. 

http://www.maxmind.com/app/ccv_overview
    EOF
    gem.email = "tm@iprog.com"
    gem.homepage = "http://github.com/zarqman/maxmind"
    gem.authors = ["Adam Daniels", "Tinu Cleatus", 't.e.morgan']
    gem.add_dependency 'activesupport', '>= 2.3'
    gem.add_development_dependency('shoulda')
    gem.add_development_dependency('matchy')
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end


task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "maxmind-rb #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

