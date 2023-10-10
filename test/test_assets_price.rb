# frozen_string_literal: true

require_relative 'test_base'

AssetsPrice = Coincap::AssetsPrice

class TestAssetsPrice < TestBase
  def setup
    @coin_name = 'bitcoin'
  end

  def test_get_all_coins
    data = JSON.parse AssetsPrice.cryptocurrencies

    assert(data.key?('data'))
    assert(data['data'].is_a?(Array))
    refute_empty data['data']
    assert_equal(100, data['data'].size)

    assert(data.key?('timestamp'))
  end

  def test_get_single_coin
    single = JSON.parse AssetsPrice.cryptocurrency(@coin_name)

    assert single.key?('data')
    assert_equal(@coin_name, single['data']['id'])
    assert(single['data'].is_a?(Hash))

    assert(single.key?('timestamp'))
  end

  def test_get_cryptocurrency_history
    history = JSON.parse AssetsPrice.cryptocurrency_history(@coin_name, 'm1')

    assert(history.key?('data'))
    assert(history['data'].is_a?(Array))
    refute_empty history['data']

    assert(history.key?('timestamp'))
  end

  def test_include_methods
    method_names = AssetsPrice::TIME_INTERVAL.keys.map { |name| "cryptocurrency_history_#{name}".to_sym }

    method_names.each do |method_name|
      assert AssetsPrice.methods.include?(method_name)
    end
  end

  def test_get_cryptocurrency_with_markets
    data = JSON.parse AssetsPrice.cryptocurrency_with_markets(@coin_name)

    assert(data.key?('data'))
    assert(data['data'].is_a?(Array))
    refute_empty data['data']
    assert_equal(100, data['data'].size)

    assert(data.key?('timestamp'))
  end
end
