require 'minitest/autorun'
require 'minitest/same_as_it_ever_was'
require 'awesome_print'
require 'minitest/reporters'

if ENV['CI_REPORTER']
  MiniTest::Reporters.use! [MiniTest::Reporters::JUnitReporter.new("test/reports", false)]
else
  MiniTest::Reporters.use! [MiniTest::Reporters::SpecReporter.new]
  # MiniTest::Reporters.use! [MiniTest::Reporters::DefaultReporter.new(:color => true)]
end

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
end
