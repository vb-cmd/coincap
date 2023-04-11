# frozen_string_literal: true

require_relative 'helper'

module Coincap
  # Take a closer look into exchanges with the /markets endpoint.
  # Similar to the /exchanges endpoint, we strive to offer transparency into how real-time
  # our data is with a key identifying when the market was last updated.
  # For a historical view on how a market has performed, see the /candles endpoint.
  # All market data represents actual trades processed, orders on an exchange are not represented.
  # Data received from individual markets is used to calculate the current price of an asset.
  module Markets
    URI_API = 'https://api.coincap.io/v2/markets'

    # Returns a list of all markets.
    #
    #   {
    #     "data": [
    #       {
    #         "exchangeId": "bitstamp",
    #         "rank": "1",
    #         "baseSymbol": "BTC",
    #         "baseId": "bitcoin",
    #         "quoteSymbol": "USD",
    #         "quoteId": "united-states-dollar",
    #         "priceQuote": "6927.3300000000000000",
    #         "priceUsd": "6927.3300000000000000",
    #         "volumeUsd24Hr": "43341291.9576547008000000",
    #         "percentExchangeVolume": "67.2199253376108585",
    #         "tradesCount24Hr": "420721",
    #         "updated": 1533581033590
    #       },
    #     ...
    #     ],
    #     "timestamp": 1533581173350
    #   }
    #
    # @param options [Hash] options for the request
    # @option options [String] :exchange_id (nil) Search by exchange id (e.g. 'binance')
    # @option options [String] :base_symbol (nil) Returns all containing the base symbol
    # @option options [String] :quote_symbol (nil) Returns all containing the quote symbol
    # @option options [String] :base_id (nil) Returns all containing the base id
    # @option options [String] :quote_id (nil) Returns all containing the quote id
    # @option options [String] :asset_symbol (nil) Returns all assets containing symbol (base and quote)
    # @option options [String] :asset_id (nil) Returns all assets containing id (base and quote)
    # @option options [Integer] :limit (nil) Max limit of 2000
    # @option options [Integer] :offset (nil) The number of results to skip
    # @return [Hash]
    def self.list(**options)
      queries = {
        'exchangeId': options[:exchange_id],
        'baseSymbol': options[:base_symbol],
        'quoteSymbol': options[:quote_symbol],
        'baseId': options[:base_id],
        'quoteId': options[:quote_id],
        'assetSymbol': options[:asset_symbol],
        'assetId': options[:asset_id],
        'limit': options[:limit],
        'offset': options[:offset]
      }
      Helper.request_to_read_data(URI_API, **queries)
    end
  end
end