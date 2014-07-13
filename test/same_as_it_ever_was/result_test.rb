require 'test_helper'

module MiniTest
  module SameAsItEverWas
    describe Result do
      let (:result) { MiniTest::SameAsItEverWas::Result.new }

      it 'should have mismatches if set' do
        result.add_mismatch 'one'
        result.add_mismatch 'two'
        result.additional.must_equal ''
        result.mismatches.must_equal 'one,two'
        result.missing.must_equal ''
        result.status.must_equal :fail
      end

      it 'should have additionals if set' do
        result.add_additional 'one'
        result.add_additional 'two'
        result.additional.must_equal 'one,two'
        result.mismatches.must_equal ''
        result.status.must_equal :pass
      end

      it 'should have missing if set' do
        result.add_missing 'one'
        result.add_missing 'two'
        result.additional.must_equal ''
        result.mismatches.must_equal ''
        result.missing.must_equal 'one,two'
        result.status.must_equal :pass
      end
    end
  end
end
