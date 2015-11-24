require 'test_helper'

class DiffTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Diff::VERSION
  end
end
