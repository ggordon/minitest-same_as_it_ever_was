module MiniTest
  module SameAsItEverWas
    class Assertion
      def initialize(context)
        @context = context
      end

      def check
        @context.assert @context.instance_variable_defined?(:@response), "Must have response to compare."
        @context.assert @context.instance_variable_defined?(:@request), "Must have request to compare."

        if results.has_key?(key)
          new_body = JSON.parse(response.body)
          old_body = results[key]['body']
          Comparer.new(old_body, new_body, @context)
        else
          results[key] = {
            'path' => request.path,
            'status' => response.status,
            'body' => JSON.parse(response.body)
          }
          File.open(results_filename, 'w') { |f| f.write(results.to_yaml) }
          @context.skip "No results found for '#{key}' appended to file: #{results_filename}"
        end
      end

      private

      def response
        @response ||= @context.response
      end

      def request
        @request ||= @context.request
      end

      def results
        @results ||= if File.exists?(results_filename)
                       YAML.load_file(results_filename) rescue Hash.new
                     else
                       Hash.new
                     end
      end

      def key
        @key ||= "#{@context.class.to_s}::#{method_name.split('_', 3).last}"
      end

      def method_name
        @method_name ||= @context.instance_variable_get('@__name__')
      end

      def results_filename
        return @results_filename if defined? @results_filename
        filename = @context.method(method_name.to_sym).source_location.first
        @results_filename = filename.gsub('_test.rb', '_resp.yml')
      end
    end
  end
end
