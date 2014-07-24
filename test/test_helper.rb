require 'minitest/autorun'
require 'minitest/same_as_it_ever_was'
require 'awesome_print'
require 'minitest/reporters'

# Minitest = MiniTest unless defined? Minitest
if ENV['CI_REPORTER']
  Minitest::Reporters.use! [Minitest::Reporters::JUnitReporter.new("test/reports", false)]
else
  Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]
  # Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(:color => true)]
end
