require "minitest/same_as_it_ever_was/version"
require 'minitest'

module MiniTest
  module SameAsItEverWas
    module Assertions
      def assert_consistent_response
        key = "#{self.class.to_s}::#{method_name.split('_', 3).last}"
        results = if File.exists?(results_filename)
                    YAML.load_file(results_filename) rescue Hash.new
                  else
                    Hash.new
                  end
        if results.has_key?(key)
          new_body = JSON.parse(response.body)
          old_body = results[key]['body']
          compare_hash(old_body, new_body)
        else
          results[key] = {
            'path' => request.path,
            'status' => response.status,
            'body' => JSON.parse(response.body)
          }
          File.open(results_filename, 'w') { |f| f.write(results.to_yaml) }
          skip "No results found for '#{key}' appended to file: #{results_filename}"
        end
      end

      def compare_hash(h1, h2)
        keys1 = h1.keys.sort
        keys2 = h2.keys.sort
        assert_equal keys1, keys2
        keys1.reject { |k| %w(id created_at updated_at).include? k }.each do |key|
          if h1[key].is_a? Hash
            compare_hash(h1[key], h2[key])
          elsif h1[key].is_a? Array
            h1[key].each_with_index { |h, i| compare_hash h, h2[key][i] }
          else
            assert_equal h1[key], h2[key], "Key '#{key}' did not match. [#{method(method_name.to_sym).source_location.join(':')}]"
          end
        end

      end

      def results_filename
        return @results_filename if defined? @results_filename
        filename = method(method_name.to_sym).source_location.first
        @results_filename = filename.gsub('_test.rb', '_resp.yml')
      end

    end
  end

  class Test
    include SameAsItEverWas::Assertions
  end
end
