require 'test_helper'

class TestExchanges < Minitest::Test
  def test_get_list_exchanges
    data = Coincap::Exchanges.list

    assert data['data'].is_a?(Array)
    assert data.key?('timestamp')
  end

  def test_get_single_exchange
    data = Coincap::Exchanges.single('binance')
    assert data.key?('data')
    assert_equal('binance', data['data']['exchangeId'])

    assert data.key?('timestamp')
  end
end
