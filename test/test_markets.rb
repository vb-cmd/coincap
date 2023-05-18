# frozen_string_literal: true

require 'test_helper'

class TestMarkets < Minitest::Test
  def test_get_all_markets
    data = JSON.parse Coincap::Markets.list
    assert data.key?('data')
    assert(data['data'].is_a?(Array))
    assert(data.key?('timestamp'))
  end
end
