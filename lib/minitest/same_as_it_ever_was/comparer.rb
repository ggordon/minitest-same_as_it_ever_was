require 'hashdiff'

module Minitest
  module SameAsItEverWas
    class Comparer

      def equal?(obj, other)
        @diff = HashDiff.diff(obj, other)
        Minitest::SameAsItEverWas::Result.new(
          mismatches: mismatches,
          missing: missing,
          additional: additional
        )
      end

      def additional
        @diff.select { |x| x.first == '+' }
      end

      def missing
        @diff.select { |x| x.first == '-' }
      end

      def mismatches
        @diff.select { |x| x.first == '~' }
      end

    end
  end
end
