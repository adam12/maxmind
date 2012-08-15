require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

desc "Run the test suite"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = FileList['spec/**/*_spec.rb']
  t.rspec_opts = %w(--color --format doc)
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.read 'VERSION' rescue nil

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "maxmind #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
