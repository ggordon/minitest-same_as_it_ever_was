module Minitest
  module SameAsItEverWas
    class Comparer

      def equal?(obj, other)
        initialize_results
        compare(obj.deep_dup, other.deep_dup)
        @results
      end

      private

      def initialize_results
        @results = Minitest::SameAsItEverWas::Result.new
      end

      def compare(elem1, elem2, root=nil)
        if compare_hashes?(elem1, elem2)
          compare_hashes(elem1, elem2, root)
        elsif compare_arrays?(elem1, elem2)
          compare_arrays(elem1, elem2, root)
        elsif elem1 != elem2
          compare_simple(elem1, elem2, root)
        else
          # success?
        end
      end

      def compare_hashes?(elem1, elem2)
        elem1.is_a?(Hash) && elem2.is_a?(Hash)
      end

      def compare_hashes(elem1, elem2, root)
        (elem1.keys - elem2.keys).each { |key| missing_msg(root, key) }
        (elem2.keys - elem1.keys).each { |key| additional_msg(root, key) }
        elem1.keys.reject.each do |key|
          next if %w(id created_at updated_at).include?(key)
          next if key.match(/.*_id$/)
          compare(elem1[key], elem2[key], path(root, key))
        end
      end

      def compare_arrays?(elem1, elem2)
        elem1.is_a?(Array) && elem2.is_a?(Array)
      end

      def compare_arrays(elem1, elem2, root)
        if elem1.size < elem2.size
          additional_msg(root)
        elsif elem1.size > elem2.size
          missing_msg(root)
        end
        elem1.each_with_index { |e, i| compare(e, elem2[i], root) }
      end

      def compare_simple(elem1, elem2, root)
        mismatch_msg(elem1, elem2, root)
      end

      def mismatch_msg(elem1, elem2, root)
        @results.add_mismatch "#{root}(expected: #{elem1.to_s}, actual: #{elem2.to_s})"
      end

      def additional_msg(root, key=nil)
        @results.add_additional path(root, key)
      end

      def missing_msg(root, key=nil)
        @results.add_missing path(root, key)
      end

      def path(root, key)
        [root, key].compact.join('.')
      end

    end
  end
end
