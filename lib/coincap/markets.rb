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
    URI_API = "#{BASE_URI}#{VERSION_API}/markets"

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
    # @param exchange_id (nil) [String] Search by exchange id (e.g. 'binance')
    # @param base_symbol (nil) [String] Returns all containing the base symbol
    # @param quote_symbol (nil) [String] Returns all containing the quote symbol
    # @param base_id (nil) [String] Returns all containing the base id
    # @param quote_id (nil) [String] Returns all containing the quote id
    # @param asset_symbol (nil) [String] Returns all assets containing symbol (base and quote)
    # @param asset_id (nil) [String] Returns all assets containing id (base and quote)
    # @param limit (nil) [Integer] Max limit of 2000
    # @param offset (nil) [Integer] The number of results to skip
    # @return [String]
    def self.list(**options)
      Helper.request_to_read_data(URI_API,
                                  exchangeId: options[:exchange_id],
                                  baseSymbol: options[:base_symbol],
                                  quoteSymbol: options[:quote_symbol],
                                  baseId: options[:base_id],
                                  quoteId: options[:quote_id],
                                  assetSymbol: options[:asset_symbol],
                                  assetId: options[:asset_id],
                                  limit: options[:limit],
                                  offset: options[:offset])
    end
  end
end
