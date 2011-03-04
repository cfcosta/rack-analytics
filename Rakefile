require 'bundler'
Bundler::GemHelper.install_tasks
Bundler.require :default

require 'rake/testtask'

desc "Run all our tests"
task :test do
  Rake::TestTask.new do |t|
    t.libs << "test"
    t.pattern = "test/**/*_test.rb"
    t.verbose = false
  end
end

desc 'Run Watchr'
task :watchr do
  system "bundle exec watchr .watchr"
end

task :default => :test
