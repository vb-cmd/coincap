require 'test_helper'

class TestRates < Minitest::Test
  def test_get_list_rates
    data = JSON.parse Coincap::Rates.list

    assert(data['data'].is_a?(Array))
    refute_empty(data['data'])

    assert(data.key?('timestamp'))
  end

  def test_get_single_rate
    data = JSON.parse Coincap::Rates.single('bitcoin')

    assert(data['data'].is_a?(Hash))
    refute_empty(data['data'])
    assert_equal('bitcoin', data['data']['id'])

    assert(data.key?('timestamp'))
  end
end
