require 'minitest/unit'
require "minitest/same_as_it_ever_was/version"
require "minitest/same_as_it_ever_was/assertion"
require "minitest/same_as_it_ever_was/comparer"
require "minitest/same_as_it_ever_was/result"

module MiniTest
  module Assertions
    def assert_consistent_response
      MiniTest::SameAsItEverWas::Assertion.new(self).check
    end
  end
end
