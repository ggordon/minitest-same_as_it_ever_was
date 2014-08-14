require 'test_helper'
require 'active_support/core_ext/object/deep_dup'

module Minitest
  module SameAsItEverWas
    describe Comparer do

      it 'should compare 2 identical simple hashes' do
        results = Comparer.new(base, base)
        assert results.pass?
        results.must_be :pass?
        results.result_method.must_equal :pass
        results.result_message.must_be_nil
      end

      it 'should not fail if an extra key' do
        results = Comparer.new(base, extra_key)
        assert results.pass?
        assert_equal('+,a.g,6', results.additional_str)
        results.result_method.must_equal :skip
        results.result_message.must_equal "New fields: '+,a.g,6', remove saved test results and regenerate."
      end

      it 'should not fail if an extra array elem' do
        results = Comparer.new(base, extra_array_elem)
        assert results.pass?
        assert_equal('+,a.d[2],h', results.additional_str)
        results.result_method.must_equal :skip
        results.result_message.must_equal "New fields: '+,a.d[2],h', remove saved test results and regenerate."
      end

      it 'should fail if missing key' do
        results = Comparer.new(base, missing_key)
        assert results.fail?
        assert_equal('-,a.c,3', results.missing_str)
        results.result_method.must_equal :flunk
        results.result_message.must_equal "Mismatch: ''; Missing: '-,a.c,3'"
      end

      it 'should fail if missing array elem' do
        results = Comparer.new(base, missing_array_elem)
        assert results.fail?
        assert_equal('-,a.d[1],f', results.missing_str)
        results.result_method.must_equal :flunk
        results.result_message.must_equal "Mismatch: ''; Missing: '-,a.d[1],f'"
      end

      it 'should report an error if 2 simple hashes are different' do
        results = Comparer.new(base, wrong_value)
        assert results.fail?
        assert_equal('~,a.c,3,5', results.mismatches_str)
        results.result_method.must_equal :flunk
        results.result_message.must_equal "Mismatch: '~,a.c,3,5'; Missing: ''"
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
