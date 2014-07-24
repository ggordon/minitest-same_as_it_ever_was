require 'test_helper'
require 'active_support/core_ext/object/deep_dup'
# begin
#   something that asserts
# rescue Minitest::Assertion => e
#   # assert_match(/Key 'a' did not match/, e.message)
# end

module Minitest
  module SameAsItEverWas
    describe Comparer do

      it 'should compare 2 identical simple hashes' do
        results = Comparer.new.equal?(base, base)
        assert_equal(:pass, results.status)
      end

      it 'should not fail if an extra key' do
        results = Comparer.new.equal?(base, extra_key)
        assert_equal(:pass, results.status)
        assert_equal('a.g', results.additional)
      end

      it 'should not fail if an extra array elem' do
        results = Comparer.new.equal?(base, extra_array_elem)
        assert_equal(:pass, results.status)
        assert_equal('a.d', results.additional)
      end

      it 'should fail if missing key' do
        results = Comparer.new.equal?(base, missing_key)
        assert_equal(:fail, results.status)
        assert_equal('a.c', results.missing)
      end

      it 'should fail if missing array elem' do
        results = Comparer.new.equal?(base, missing_array_elem)
        assert_equal(:fail, results.status)
        assert_equal('a.d', results.missing)
      end

      it 'should report an error if 2 simple hashes are different' do
        results = Comparer.new.equal?(base, wrong_value)
        assert_equal(:fail, results.status)
        assert_equal('a.c(expected: 3, actual: 5)', results.mismatches)
      end

      let(:base) {
        { 'a' => { 'b' => 1, 'c' => 3, 'd' => ['e', 'f'] } }
      }
      let(:wrong_value) {
        base.deep_dup.tap { |x| x['a']['c'] = 5 }
      }
      let(:missing_key) {
        base.deep_dup.tap { |x| x['a'].delete('c') }
      }
      let(:extra_key) {
        base.deep_dup.tap { |x| x['a']['g'] = 6 }
      }
      let(:missing_array_elem) {
        base.deep_dup.tap { |x| x['a']['d'] = x['a']['d'][0..0] }
      }
      let(:extra_array_elem) {
        base.deep_dup.tap { |x| x['a']['d'] << 'h' }
      }

    end
  end
end
