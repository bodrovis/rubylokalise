# frozen_string_literal: true

require 'rake'
require 'rspec/core/rake_task'

begin
  require 'bundler/setup'
  Bundler::GemHelper.install_tasks
rescue LoadError
  puts 'although not required, bundler is recommened for running the tests'
end

RSpec::Core::RakeTask.new(:spec)
