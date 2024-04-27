# frozen_string_literal: true

require_relative 'helper'

module Coincap
  # All prices on the CoinCap API are standardized in USD (United States Dollar).
  # To make translating to other values easy, CoinCap now offers a Rates endpoint.
  # We offer fiat and top cryptocurrency translated rates.
  # Fiat rates are available through OpenExchangeRates.org.
  module Rates
    URI_API = "#{BASE_URI}#{VERSION_API}/rates"

    # Returns a list of all rates.
    #
    #   {
    #     "data": [
    #       {
    #         "id": "barbadian-dollar",
    #         "symbol": "BBD",
    #         "currencySymbol": "$",
    #         "type": "fiat",
    #         "rateUsd": "0.5000000000000000"
    #       },
    #     ...
    #     ],
    #     "timestamp": 1536347807471
    #   }
    #
    # @return [Hash]
    def self.list
      Helper.fetch_data(URI_API)
    end

    # Returns a single rate.
    #
    #   {
    #     "data": {
    #       "id": "bitcoin",
    #       "symbol": "BTC",
    #       "currencySymbol": "₿",
    #       "type": "crypto",
    #       "rateUsd": "6444.3132749056076909"
    #     },
    #     "timestamp": 1536347871542
    #   }
    #
    # @param asset_id [String] The asset id (bitcoin)
    # @return [Hash]
    def self.single(asset_id)
      Helper.fetch_data("#{URI_API}/#{asset_id}")
    end
  end
end
