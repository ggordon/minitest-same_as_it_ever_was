require 'minitest/autorun'
require 'minitest/same_as_it_ever_was'
require 'awesome_print'

describe 'SameAsItEverWas' do
  it 'should test something' do
    assert true
  end

  it 'should be an error if no response is defined' do
    begin
      assert_consistent_response
    rescue MiniTest::Assertion => e
      assert_match(/Must have response to compare/, e.message)
    end
  end
end
