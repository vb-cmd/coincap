# frozen_string_literal: true

require_relative 'test_base'

Assets = Coincap::Assets

class TestAssets < TestBase
  def setup
    @coin_name = 'bitcoin'
  end

  def test_get_all_coins
    data = Assets.list

    assert(data.key?('data'))
    assert(data['data'].is_a?(Array))
    refute_empty data['data']
    assert_equal(100, data['data'].size)

    assert(data.key?('timestamp'))
  end

  def test_get_single_coin
    single = Assets.single(@coin_name)

    assert single.key?('data')
    assert_equal(@coin_name, single['data']['id'])
    assert(single['data'].is_a?(Hash))

    assert(single.key?('timestamp'))
  end

  def test_get_history
    history = Assets.history(@coin_name, 'm1')

    assert(history.key?('data'))
    assert(history['data'].is_a?(Array))
    refute_empty history['data']

    assert(history.key?('timestamp'))
  end

  def test_get_history_with_timestamp
    start_at = 1_682_623_130_000
    end_at = 1_695_842_330_000

    history = Assets.history_one_day(@coin_name, start_at, end_at)

    assert(history.key?('data'))
    assert(history['data'].is_a?(Array))

    refute_empty history['data']

    assert(history.key?('timestamp'))

    assert(start_at < history['data'].first['time'])
    assert(end_at > history['data'].last['time'])
  end

  def test_include_methods
    method_names = Assets::TIME_INTERVAL.keys.map { |name| "history_#{name}".to_sym }

    method_names.each do |method_name|
      assert Assets.methods.include?(method_name)
    end
  end

  def test_get_markets
    data = Assets.markets(@coin_name)

    assert(data.key?('data'))
    assert(data['data'].is_a?(Array))
    refute_empty data['data']
    assert_equal(100, data['data'].size)

    assert(data.key?('timestamp'))
  end
end
