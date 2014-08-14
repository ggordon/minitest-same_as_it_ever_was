require 'minitest/unit'
require "minitest/same_as_it_ever_was/version"
require "minitest/same_as_it_ever_was/assertion"
require "minitest/same_as_it_ever_was/comparer"
require "minitest/same_as_it_ever_was/results_file"

module Minitest
  module Assertions
    def assert_consistent_response
      Minitest::SameAsItEverWas::Assertion.new(self).check
    end
  end
end
Minitest = MiniTest unless defined? Minitest
