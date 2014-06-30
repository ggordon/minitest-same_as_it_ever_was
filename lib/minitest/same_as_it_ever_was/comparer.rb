module MiniTest
  module SameAsItEverWas
    class Comparer
      def initialize(context, obj, other)
        @context = context
        @obj = obj
        @other = other
      end

      def compare
        keys1 = @obj.keys.sort
        keys2 = @other.keys.sort
        @context.assert_equal keys1, keys2
        keys1.reject { |k| %w(id created_at updated_at).include? k }.each do |key|
          if @obj[key].is_a? Hash
            Comparer.new(@obj[key], @other[key], @context).compare
          elsif @obj[key].is_a? Array
            @obj[key].each_with_index { |h, i| Comparer.new(h, @other[key][i], @context) }
          else
            @context.assert_equal @obj[key], @other[key], "Key '#{key}' did not match. [#{@context.method(method_name.to_sym).source_location.join(':')}]"
          end
        end
      end

      private

      def method_name
        @method_name ||= @context.instance_variable_get('@__name__')
      end
    end
  end
end
