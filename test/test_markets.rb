# frozen_string_literal: true

require_relative 'test_base'

Markets = Coincap::Markets

class TestMarkets < TestBase
  def test_get_all_markets
    data = JSON.parse Markets.list
    assert data.key?('data')
    assert(data['data'].is_a?(Array))
    assert(data.key?('timestamp'))
  end
end
