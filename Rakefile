require 'rspec/core/rake_task'

desc "Run the test suite"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = FileList['spec/**/*_spec.rb']
  t.rspec_opts = %w(--color --format doc)
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

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.read 'VERSION' rescue nil

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "maxmind #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

