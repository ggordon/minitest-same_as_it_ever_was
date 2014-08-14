require 'test_helper'

# begin
#   something that asserts
# rescue Minitest::Assertion => e
#   # assert_match(/Key 'a' did not match/, e.message)
# end

module Minitest
  module SameAsItEverWas
    class DummyContext
      def name; 'test0001'; end
      def test0001; true; end
    end

    describe Assertion do
      let (:context) { DummyContext.new }
      let (:assertion) { Minitest::SameAsItEverWas::Assertion.new(self) }

      it 'must have a response' do
        begin
          assertion.check
        rescue Minitest::Assertion => e
          assert_match(/Must have response to compare./, e.message)
        end
      end
      it 'must have a request' do
        @response = ''
        begin
          assertion.check
        rescue Minitest::Assertion => e
          assert_match(/Must have request to compare./, e.message)
        end
      end
      it 'must compare something' do
        # probably a better way...
        @response = ''
        @request = ''
        assertion.stub(:compare_results, true) do
          assert assertion.check
        end
      end
    end
  end
end
