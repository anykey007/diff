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
    attr_reader :original_line, :new_line

    def initialize(original_line, new_line)
      @original_line = original_line
      @new_line      = new_line
    end

    def find
      return unless original_line && new_line

      lcs_length        = 0
      last_lcs_char_pos = 0

      new_line.size.times do |row_index|
        positions = substring_positions(new_line[row_index], original_line)

        positions.each do |col_index|
          table_of_accordance[row_index][col_index] = 1

          next if row_index == 0 || col_index == 0

          prev_lcs_length = table_of_accordance[row_index - 1][col_index - 1]
          next if prev_lcs_length == 0

          table_of_accordance[row_index][col_index] = prev_lcs_length + 1
          next unless table_of_accordance[row_index][col_index] > lcs_length

          lcs_length        = table_of_accordance[row_index][col_index]
          last_lcs_char_pos = col_index
        end
      end

      return '' if lcs_length == 0
      original_line[last_lcs_char_pos - lcs_length + 1..last_lcs_char_pos]
    end

    private

    def table_of_accordance
       @_table_of_accordance ||= Array.new(new_line.size) { Array.new(original_line.size, 0) }
    end

    def substring_positions(substring, string)
      string.enum_for(:scan, substring).map { $~.offset(0)[0] }
    end
  end
end
