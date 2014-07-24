module Minitest
  module SameAsItEverWas
    class Result
      def initialize
        @mismatches = []
        @missing    = []
        @additional = []
      end

      # %w(mismatch missing new).each do |m|
      #   define_method "add_#{m}" do
      #
      #   end
      # end
      def add_mismatch msg
        @mismatches << msg
      end

      def add_missing msg
        @missing << msg
      end

      def add_additional msg
        @additional << msg
      end

      def status
        if @mismatches.empty?
          :pass
        else
          :fail
        end
      end

      def pass?
        status == :pass
      end

      def additional?
        !@additional.empty?
      end

      def additional
        @additional.join(',')
      end

      def missing
        @missing.join(',')
      end

      def mismatches
        @mismatches.join(',')
      end
    end
  end
end
