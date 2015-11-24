module Diff
  # Provides searching longest common substring (LCS) using
  # table of accordance
  #   SUBSEQUENCE (original line)
  # S 10010000000
  # U 02000010000
  # B 00300000000
  # E 00001001001
  # U 01000010000
  # E 00001002001
  # N 00000000300
  # C 00000000040
  # S 10010000000

  class Lcs
    attr_reader :original_array, :new_array

    def initialize(original_array, new_array)
      fail ArgumentError, "Arguments must be arrays." \
        unless original_array.kind_of?(Array) && new_array.kind_of?(Array)

      @original_array = original_array
      @new_array      = new_array
    end

    def find
      lcs_length        = 0
      last_lcs_char_pos = 0

      new_array.each_with_index do |new_array_value, i|
        original_array.each_with_index do |original_array_value, j|
          next unless new_array_value == original_array_value

          table_of_accordance[i][j] = 1

          next if i == 0 || j == 0

          prev_lcs_length = table_of_accordance[i - 1][j - 1]
          next if prev_lcs_length == 0

          table_of_accordance[i][j] = prev_lcs_length + 1
          next unless table_of_accordance[i][j] > lcs_length

          lcs_length        = table_of_accordance[i][j]
          last_lcs_char_pos = j
        end
      end

      return [] if lcs_length == 0
      original_array[last_lcs_char_pos - lcs_length + 1..last_lcs_char_pos]
    end

    private

    def table_of_accordance
       @_table_of_accordance ||= Array.new(new_array.size) { Array.new(original_array.size, 0) }
    end
  end
end
