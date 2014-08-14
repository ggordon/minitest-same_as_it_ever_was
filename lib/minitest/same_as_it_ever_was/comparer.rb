require 'hashdiff'

module Minitest
  module SameAsItEverWas
    class Comparer

      def initialize(obj, other)
        @obj = obj
        @other = other
      end

      def pass?
        (mismatches.nil? || mismatches.empty?) && (missing.nil? || missing.empty?)
      end

      def fail?
        !pass?
      end

      def diff
        @diff ||= HashDiff.diff(@obj, @other)
      end

      def additional
        @additional ||= diff.select { |x| x.first == '+' }
      end

      def missing
        @missing ||= diff.select { |x| x.first == '-' }
      end

      def mismatches
        @mismatches ||= diff.select { |x| x.first == '~' }
      end

      def additional_str
        additional && additional.join(',')
      end

      def missing_str
        missing && missing.join(',')
      end

      def mismatches_str
        mismatches && mismatches.join(',')
      end
    end
  end
end
