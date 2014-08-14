require 'test_helper'

# begin
#   something that asserts
# rescue Minitest::Assertion => e
#   # assert_match(/Key 'a' did not match/, e.message)
# end

module Minitest
  module SameAsItEverWas
    describe Assertion do
      it 'should test something' do
        skip 'need to test something here.'
      end
    end
  end
end
