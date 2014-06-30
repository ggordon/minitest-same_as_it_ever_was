require 'minitest/autorun'
require 'minitest/same_as_it_ever_was'
require 'awesome_print'
require 'minitest/reporters'

if ENV['CI_REPORTER']
  MiniTest::Reporters.use! [MiniTest::Reporters::JUnitReporter.new("test/reports", false)]
else
  MiniTest::Reporters.use! [MiniTest::Reporters::SpecReporter.new]
  # MiniTest::Reporters.use! [MiniTest::Reporters::DefaultReporter.new(:color => true)]
end
