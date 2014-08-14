module Minitest
  module SameAsItEverWas
    class Result
      def initialize(o={})
        @mismatches = o[:mismatches]
        @missing    = o[:missing]
        @additional = o[:additional]
      end

      def pass?
        (@mismatches.nil? || @mismatches.empty?) && (@missing.nil? || @missing.empty?)
      end

      def fail?
        !pass?
      end

      def additional?
        @additional && !@additional.empty?
      end

      def additional
        @additional && @additional.join(',')
      end

      def missing
        @missing && @missing.join(',')
      end

      def mismatches
        @mismatches && @mismatches.join(',')
      end
    end
  end
end
