require 'test_helper'

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

  it 'should be an error if no request is defined' do
    @response = nil
    begin
      assert_consistent_response
    rescue MiniTest::Assertion => e
      assert_match(/Must have request to compare/, e.message)
    end
  end

  # describe 'no previous results' do
  #   it 'should create a file' do
  #     @response = 'x'
  #     Request = Struct.new(:path)
  #     @request = Request.new(path: 'x/y')
  #     assert_consistent_response
  #   end
  # end
end
