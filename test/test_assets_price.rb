# frozen_string_literal: true

require 'test_helper'

class TestAssetsPrice < Minitest::Test
  def test_get_all_coins
    data = Coincap::AssetsPrice.cryptocurrencies

    assert(data.key?('data'))
    assert(data['data'].is_a?(Array))
    refute_empty data['data']
    assert_equal(100, data['data'].size)

    assert(data.key?('timestamp'))
  end

  def test_get_single_coin
    single = Coincap::AssetsPrice.cryptocurrency('bitcoin')

    assert single.key?('data')
    assert_equal('bitcoin', single['data']['id'])
    assert(single['data'].is_a?(Hash))

    assert(single.key?('timestamp'))
  end

  def test_get_cryptocurrency_history
    history = Coincap::AssetsPrice.cryptocurrency_history('bitcoin', :one_minute)

    assert(history.key?('data'))
    assert(history['data'].is_a?(Array))
    refute_empty history['data']

    assert(history.key?('timestamp'))
  end

  def test_get_cryptocurrency_with_markets
    data = Coincap::AssetsPrice.cryptocurrency_with_markets('bitcoin')

    assert(data.key?('data'))
    assert(data['data'].is_a?(Array))
    refute_empty data['data']
    assert_equal(100, data['data'].size)

    assert(data.key?('timestamp'))
  end
end
