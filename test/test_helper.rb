begin
  require 'byebug'
rescue LoadError
end
require 'minitest/reporters'
Minitest::Reporters.use! [Minitest::Reporters::ProgressReporter.new]
require 'minitest/autorun'

ENV['RAILS_ENV'] = 'test'

require 'cell/erb'
require_relative 'dummy/config/environment'
