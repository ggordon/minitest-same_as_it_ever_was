require 'hashdiff'

module Minitest
  module SameAsItEverWas
    class Comparer

      def equal?(obj, other)
        diff = HashDiff.diff(obj, other)
        mismatches = diff.select { |x| x.first == '~' }
        missing = diff.select { |x| x.first == '-' }
        additional = diff.select { |x| x.first == '+' }
        Minitest::SameAsItEverWas::Result.new(mismatches: mismatches, missing: missing, additional: additional)
      end

    end
  end
end
