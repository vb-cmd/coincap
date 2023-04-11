# frozen_string_literal: true

require_relative 'helper'

module Coincap
  # The asset price is a volume-weighted average calculated by collecting ticker data from exchanges.
  # Each exchange contributes to this price in relation to their volume,
  # meaning higher volume exchanges have more affect on this global price.
  # All values are translated into USD (United States Dollar)
  # and can be translated into other units of measurement through the /rates endpoint.
  module AssetsPrice
    URI_API = 'https://api.coincap.io/v2/assets'

    TIME_INTERVAL = {
      one_minute: 'm1',
      five_minutes: 'm5',
      fifteen_minutes: 'm15',
      thirty_minutes: 'm30',
      one_hour: 'h1',
      two_hours: 'h2',
      six_hours: 'h6',
      twelve_hours: 'h12',
      one_day: 'd1'
    }.freeze

    class << self
      # Get all cryptocurrencies
      #
      #   {
      #     "data": [
      #       {
      #       "id": "bitcoin",
      #       "rank": "1",
      #       "symbol": "BTC",
      #       "name": "Bitcoin",
      #       "supply": "17193925.0000000000000000",
      #       "maxSupply": "21000000.0000000000000000",
      #       "marketCapUsd": "119150835874.4699281625807300",
      #       "volumeUsd24Hr": "2927959461.1750323310959460",
      #       "priceUsd": "6929.8217756835584756",
      #       "changePercent24Hr": "-0.8101417214350335",
      #       "vwap24Hr": "7175.0663247679233209"
      #       },
      #    ...
      #     ],
      #     "timestamp": 1533581088278
      #   }
      #
      # @param [Hash] options
      # @option options [String] :search (nil) Search by asset id (bitcoin) or symbol (BTC)
      # @option options [String] :ids (nil) Query with multiple ids=bitcoin,ethereum,monero
      # @option options [Integer] :limit (nil) Max limit of 2000
      # @option options [Integer] :offset (nil) Offset
      # @return [Hash]
      def cryptocurrencies(**options)
        quries = {
          'search': options[:search],
          'ids': options[:ids],
          'limit': options[:limit],
          'offset': options[:offset]
        }
        Helper.request_to_read_data(URI_API, **quries)
      end

      # Get single cryptocurrency
      #
      #   {
      #     "data": {
      #       "id": "bitcoin",
      #       "rank": "1",
      #       "symbol": "BTC",
      #       "name": "Bitcoin",
      #       "supply": "17193925.0000000000000000",
      #       "maxSupply": "21000000.0000000000000000",
      #       "marketCapUsd": "119179791817.6740161068269075",
      #       "volumeUsd24Hr": "2928356777.6066665425687196",
      #       "priceUsd": "6931.5058555666618359",
      #       "changePercent24Hr": "-0.8101417214350335",
      #       "vwap24Hr": "7175.0663247679233209"
      #     },
      #     "timestamp": 1533581098863
      #   }
      #
      # @param [String] asset_id Asset id, for example, bitcoin
      # @return [Hash]
      def cryptocurrency(asset_id)
        Helper.request_to_read_data("#{URI_API}/#{asset_id}")
      end

      # Get cryptocurrency history price
      #
      #   {
      #     "data": [
      #      {
      #         "priceUsd": "6379.3997635993342453",
      #         "time": 1530403200000
      #       },
      #     ...
      #     ],
      #     "timestamp": 1533581103627
      #   }
      #
      # @param [String] asset_id Asset id, for example, bitcoin
      # @param [Symbol] interval Select one from the list m1,m5,m15,m30,h1,h2,h6,h12,d1, for example, m1 or write a symbol, for example, :one_minute
      def cryptocurrency_history(asset_id, interval)
        Helper.request_to_read_data("#{URI_API}/#{asset_id}/history",
                                    interval: interval.is_a?(Symbol) ? TIME_INTERVAL[interval] : interval)
      end

      # Get price cryptocurrency with markets
      #
      #   {
      #     "data": [
      #       {
      #         "exchangeId": "Binance",
      #         "baseId": "bitcoin",
      #         "quoteId": "tether",
      #         "baseSymbol": "BTC",
      #         "quoteSymbol": "USDT",
      #         "volumeUsd24Hr": "277775213.1923032624064566",
      #         "priceUsd": "6263.8645034633024446",
      #         "volumePercent": "7.4239157877678087"
      #       },
      #       ...
      #     ],
      #     "timestamp": 1539289444052
      #   }
      #
      # @param [String] asset_id Asset id, for example, bitcoin
      # @param [Integer] limit Max limit of 2000
      # @param [Integer] offset Offset
      def cryptocurrency_with_markets(asset_id, limit: nil, offset: nil)
        Helper.request_to_read_data("#{URI_API}/#{asset_id}/markets", limit: limit, offset: offset)
      end
    end
  end
end
