module Minitest
  module SameAsItEverWas
    class Assertion
      def initialize(context)
        @context = context
      end

      def check
        integration_test?
        if results.has_key?(key)
          compare_existing_results
        else
          generate_new_results
        end
      end

      def results_file
        @results_file ||= ResultsFile.new(@context)
      end

      def generate_new_results
        results[key] = {
          'path'   => request.path,
          'status' => response.status,
          'body'   => current_response_body
        }
        results_file.write(results)
        @context.skip "No results found for '#{key}' appended to file: #{results_file.filename}"
      end

      def compare_existing_results
        c = Comparer.new(previous_response_body, current_response_body)
        # ap c
        if c.pass?
          if c.additional?
            @context.flunk "New fields: '#{c.additional_str}', remove saved test results and regenerate."
          else
            @context.pass
          end
        else
          @context.flunk "Mismatch: '#{c.mismatches_str}'; Missing: '#{c.missing_str}'"
        end
      end

      def integration_test?
        @context.assert @context.instance_variable_defined?(:@response), "Must have response to compare."
        @context.assert @context.instance_variable_defined?(:@request), "Must have request to compare."
      end

      def previous_response_body
        results[key]['body']
      end

      def current_response_body
        @current_response_body ||= JSON.parse(response.body)
      end

      private

      def response
        @response ||= @context.response
      end

      def request
        @request ||= @context.request
      end

      def results
        results_file.contents
      end

      def key
        @key ||= "#{@context.class.to_s}::#{method_name.split('_', 3).last}"
      end

      def method_name
        @method_name ||= begin
          if @context.respond_to? :name
            @context.name
          else
            @context.instance_variable_get('@__name__')
          end
        end
      end

    end
  end
end
