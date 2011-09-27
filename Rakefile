# encoding: utf-8
require 'bundler'
Bundler::GemHelper.install_tasks
require 'rspec/core/rake_task'
require 'rdoc/task'

# Rake tasks from https://github.com/mojombo/rakegem/blob/master/Rakefile

# Helper Functions
def name
  @name ||= Dir['*.gemspec'].first.split('.').first
end
require 'rake'
$LOAD_PATH.unshift('lib')
require 'gitolite'
require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end
task :test => :spec
task :default => :spec

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -r ./lib/#{name}.rb"
end
