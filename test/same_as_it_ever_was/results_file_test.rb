require 'test_helper'

module Minitest
  module SameAsItEverWas
    class DummyContext
      def name; 'test0001'; end
      def test0001; true; end
    end
    describe ResultsFile do
      let (:context) { DummyContext.new }
      let (:results_file) { Minitest::SameAsItEverWas::ResultsFile.new(context) }

      it 'should calculate the correct filename' do
        results_file.filename.must_match(/minitest-same_as_it_ever_was\/test\/same_as_it_ever_was\/results_file_resp.yml\z/)
      end

      it 'should not have any contents since it does not exist' do
        results_file.contents.must_be_instance_of Hash
        results_file.contents.must_be :empty?
      end

      it 'should save results' do
        skip 'need to mock file save'
      end
    end
  end
end
