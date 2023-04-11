# frozen_string_literal: true

require_relative 'helper'

module Coincap
  # The /exchanges endpoint offers an understanding into the where cryptocurrency
  # is being exchanged and offers high-level information on those exchanges.
  #
  # CoinCap strives to provide transparency in the recency of our exchange data.
  #
  # For that purpose you will find an "updated" key for each exchange.
  # For more details into coin pairs and volume, see the /markets endpoint.
  module Exchanges
    URI_API = 'https://api.coincap.io/v2/exchanges'
    class << self
      # Returns a list of all exchanges.
      #
      #   {
      #     "data": [
      #       {
      #         "id": "okex",
      #         "name": "Okex",
      #         "rank": "1",
      #         "percentTotalVolume": "21.379485735166293542000000000000000000",
      #         "volumeUsd": "616465445.1646260280799955",
      #         "tradingPairs": "22",
      #         "socket": false,
      #         "exchangeUrl": "https://www.okex.com/",
      #         "updated": 1536343139514
      #       },
      #     ...
      #     ],
      #     "timestamp": 1536605835421
      #   }
      #
      # @return [Hash]
      def list
        Helper.request_to_read_data(URI_API)
      end

      # Returns a single exchange.
      #
      #   {
      #     "data": {
      #       "id": "kraken",
      #       "name": "Kraken",
      #       "rank": "4",
      #       "percentTotalVolume": "2.946801735133553120000000000000000000",
      #       "volumeUsd": "84969370.4499608426167365",
      #       "tradingPairs": "52",
      #       "socket": false,
      #       "exchangeUrl": "https://kraken.com",
      #       "updated": 1536343139468
      #     },
      #     "timestamp": 1536605874069
      #   }
      #
      # @param exchange_id [String]
      # @return [Hash]
      def single(exchange_id)
        Helper.request_to_read_data("#{URI_API}/#{exchange_id}")
      end
    end
  end
end
