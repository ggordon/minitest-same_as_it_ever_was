module Minitest
  module SameAsItEverWas
    class ResultsFile
      def initialize(context)
        @context = context
      end


      def filename
        return @filename if defined? @filename
        filename = @context.method(method_name.to_sym).source_location.first
        @filename = filename.gsub('_test.rb', '_resp.yml')
      end

      def load
        YAML.load_file(@filename) rescue Hash.new
      end

      def write(results)
        File.open(filename, 'w') { |f| f.write(results.to_yaml) }
      end

      def contents
        @contents ||= File.exists?(filename) ? load : Hash.new
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
