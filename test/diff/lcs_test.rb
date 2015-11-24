require 'test_helper'

class LcsTest < Minitest::Test
  def test_find_lcs_for_chars
    expected_lcs = %w(U E N C)
    assert_equal expected_lcs, Diff::Lcs.new('SUBSEQUENCE'.chars, 'SUBEUENCS'.chars).find
    assert_equal expected_lcs, Diff::Lcs.new('SUBSEQUENCE'.chars, 'SUBEUUENCS'.chars).find
    assert_equal expected_lcs, Diff::Lcs.new('SUBEUENCS'.chars, 'SUBSEQUENCE'.chars).find
    assert_equal expected_lcs, Diff::Lcs.new('SUBEUUENCS'.chars, 'SUBSEQUENCE'.chars).find
  end

  def test_find_lcs_for_strings
    original_array = %w(Some Simple Text File)
    new_array      = %w(Another Text File With Additional Lines)
    expected_lcs   = %w(Text File)

    assert_equal expected_lcs, Diff::Lcs.new(original_array, new_array).find
    assert_equal expected_lcs, Diff::Lcs.new(new_array, original_array).find
  end

  def test_find_lcs_on_empty_arrays
    assert_equal [], Diff::Lcs.new('SUBSEQUENCE'.chars, []).find
    assert_equal [], Diff::Lcs.new([], 'SUBSEQUENCE'.chars).find
  end

  def test_raise_errors_on_nil_arguments
    assert_raises(ArgumentError) { Diff::Lcs.new(nil, 'SUBSEQUENCE'.chars).find }
    assert_raises(ArgumentError) { Diff::Lcs.new('SUBSEQUENCE'.chars, nil).find }
    assert_raises(ArgumentError) { Diff::Lcs.new(nil, nil).find }
  end
end
