# frozen_string_literal: true

require_relative 'test_base'

class TestCoincap < TestBase
  def test_that_it_has_a_version_number
    refute_nil ::Coincap::VERSION
  end
end
