module Minitest
  module SameAsItEverWas
    class Assertion
      def initialize(context)
        @context = context
      end

      def check
        integration_test_check
        compare_results
      end

      def integration_test_check
        @context.assert @context.instance_variable_defined?(:@response), "Must have response to compare."
        @context.assert @context.instance_variable_defined?(:@request), "Must have request to compare."
      end

      def compare_results
        results.has_key?(key) ? compare_with_previous_results : generate_results_and_warn
      end

      def results
        results_file.contents
      end

      def results_file
        @results_file ||= ResultsFile.new(@context)
      end

      def compare_with_previous_results
        c = Comparer.new(results[key]['body'], JSON.parse(@context.response.body))
        @context.send(c.result_method, c.result_message)
      end

      def generate_results_and_warn
        results[key] = {
          'path'   => @context.request.path,
          'status' => @context.response.status,
          'body'   => JSON.parse(@context.response.body)
        }
        results_file.write(results)
        @context.skip "No results found for '#{key}' appended to file: #{results_file.filename}"
      end

      private

      def key
        @key ||= "#{@context.class.to_s}::#{results_file.method_name.split('_', 3).last}"
      end
    end
  end
end
