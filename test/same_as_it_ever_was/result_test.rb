require 'test_helper'

module Minitest
  module SameAsItEverWas
    describe Result do
      let (:result) {  }

      it 'should have mismatches if set' do
        result = Minitest::SameAsItEverWas::Result.new(['one', 'two'], nil, nil)
        result.additional.must_equal nil
        result.mismatches.must_equal 'one,two'
        result.missing.must_equal nil
        result.status.must_equal :fail
      end

      it 'should have additionals if set' do
        result = Minitest::SameAsItEverWas::Result.new(nil, nil, ['one', 'two'])
        result.additional.must_equal 'one,two'
        result.mismatches.must_equal nil
        result.missing.must_equal nil
        result.status.must_equal :pass
      end

      it 'should have missing if set' do
        result = Minitest::SameAsItEverWas::Result.new(nil, ['one', 'two'], nil)
        result.additional.must_equal nil
        result.mismatches.must_equal nil
        result.missing.must_equal 'one,two'
        result.status.must_equal :fail
      end
    end
  end
end
