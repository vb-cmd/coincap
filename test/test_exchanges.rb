# frozen_string_literal: true

require_relative 'test_base'

Exchanges = Coincap::Exchanges

class TestExchanges < Minitest::Test
  def test_get_list_exchanges
    data = Exchanges.list

    assert data['data'].is_a?(Array)
    assert data.key?('timestamp')
  end

  def test_get_single_exchange
    data = Exchanges.single('binance')
    assert data.key?('data')
    assert_equal('binance', data['data']['exchangeId'])

    assert data.key?('timestamp')
  end
end
