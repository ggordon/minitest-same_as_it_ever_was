require 'test_helper'

module Minitest
  module SameAsItEverWas
    describe Result do
      let (:result) {  }

      it 'should have mismatches if set' do
        result = Minitest::SameAsItEverWas::Result.new(mismatches: ['one', 'two'])
        result.additional.must_equal nil
        result.mismatches.must_equal 'one,two'
        result.missing.must_equal nil
        result.status.must_equal :fail
      end

      it 'should have additionals if set' do
        result = Minitest::SameAsItEverWas::Result.new(additional: ['one', 'two'])
        result.additional.must_equal 'one,two'
        result.mismatches.must_equal nil
        result.missing.must_equal nil
        result.status.must_equal :pass
      end

      it 'should have missing if set' do
        result = Minitest::SameAsItEverWas::Result.new(missing: ['one', 'two'])
        result.additional.must_equal nil
        result.mismatches.must_equal nil
        result.missing.must_equal 'one,two'
        result.status.must_equal :fail
      end
    end
  end
end
