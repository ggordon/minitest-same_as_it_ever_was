require 'test_helper'

module MiniTest
  module SameAsItEverWas
    describe Comparer do
      it 'should compare 2 identical simple hashes' do
        h1 = { 'a' => 1 }
        h2 = { 'a' => 1 }
        begin
          Comparer.new(self, h1, h2).compare
          assert true, 'compare worked'
        rescue MiniTest::Assertion => e
          flunk 'should\'ve compared successfully '
        end
      end
      it 'should report an error if 2 simple hashes are different' do
        h1 = { 'a' => 1 }
        h2 = { 'a' => 2 }
        begin
          Comparer.new(self, h1, h2).compare
          flunk 'compare worked?'
        rescue MiniTest::Assertion => e
          assert_match(/Key 'a' did not match/, e.message)
        end
      end
    end
  end
end
