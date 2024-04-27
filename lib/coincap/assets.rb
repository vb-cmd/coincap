# frozen_string_literal: true

require_relative 'helper'

module Coincap
  # The asset price is a volume-weighted average calculated by collecting ticker data from exchanges.
  # Each exchange contributes to this price in relation to their volume,
  # meaning higher volume exchanges have more affect on this global price.
  # All values are translated into USD (United States Dollar)
  # and can be translated into other units of measurement through the /rates endpoint.
  module Assets
    URI_API = "#{BASE_URI}#{VERSION_API}/assets"

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
    # @param [String] search (nil) Search by asset id (bitcoin) or symbol (BTC)
    # @param [String] ids (nil) Query with multiple ids=bitcoin,ethereum,monero
    # @param [Integer] limit (nil) Max limit of 2000
    # @param [Integer] offset (nil) Offset
    # @return [Hash]
    def self.list(search: nil, ids: nil, limit: nil, offset: nil)
      Helper.fetch_data(URI_API, search: search, ids: ids, limit: limit, offset: offset)
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
    # @param asset_id [String] Asset id, for example, bitcoin
    # @return [Hash]
    def self.single(asset_id)
      Helper.fetch_data("#{URI_API}/#{asset_id}")
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
    # You can call the method like this:
    #
    #   Coincap::AssetsPrice.cryptocurrency_history('bitcoin', :one_minute)
    #
    #   Coincap::AssetsPrice.cryptocurrency_history('bitcoin', 'm1')
    #
    #
    # Or like this:
    #
    #   Coincap::AssetsPrice.cryptocurrency_history_one_minute('bitcoin')
    #
    # @param asset_id [String] Asset id, for example, bitcoin
    # @param interval [Symbol|String] Select one from the list of TIME_INTERVAL values
    #   for example, a string 'm1' or a symbol :one_minute
    # @param start_at [Integer] Start time in milliseconds
    # @param end_at [Integer] End time in milliseconds
    # @return [Hash]
    def self.history(asset_id, interval, start_at = nil, end_at = nil)
      Helper.fetch_data("#{URI_API}/#{asset_id}/history",
                        interval: interval.is_a?(Symbol) ? TIME_INTERVAL[interval] : interval,
                        start: start_at,
                        end: end_at)
    end

    TIME_INTERVAL.each do |key, value|
      class_eval <<~RUBY
        def self.history_#{key}(asset_id, start_at = nil, end_at = nil)
          self.history(asset_id, '#{value}', start_at, end_at)
        end
      RUBY
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
    # @param asset_id [String] Asset id, for example, bitcoin
    # @param limit [Integer] Max limit of 2000
    # @param offset [Integer] Offset
    # @return [Hash]
    def self.markets(asset_id, limit: nil, offset: nil)
      Helper.fetch_data("#{URI_API}/#{asset_id}/markets", limit: limit, offset: offset)
    end
  end
end
