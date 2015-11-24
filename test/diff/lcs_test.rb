require 'test_helper'

class LcsTest < Minitest::Test
  def test_find_lcs
    assert_equal 'UENC', Diff::Lcs.new('SUBSEQUENCE', 'SUBEUENCS').find
    assert_equal 'UENC', Diff::Lcs.new('SUBSEQUENCE', 'SUBEUUENCS').find
    assert_equal 'UENC', Diff::Lcs.new('SUBEUENCS', 'SUBSEQUENCE').find
    assert_equal 'UENC', Diff::Lcs.new('SUBEUUENCS', 'SUBSEQUENCE').find
  end

  def test_find_lcs_on_empty_strings
    assert_equal '', Diff::Lcs.new('SUBSEQUENCE', '').find
    assert_equal '', Diff::Lcs.new('', 'SUBSEQUENCE').find
  end

  def test_find_lcs_on_nil_args
    refute Diff::Lcs.new(nil, 'SUBSEQUENCE').find
    refute Diff::Lcs.new('SUBSEQUENCE', nil).find
    refute Diff::Lcs.new(nil, nil).find
  end
end
