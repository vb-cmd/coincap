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
      # @param [String] asset_id Asset id, for example, bitcoin
      # @return [Hash]
      def cryptocurrency(asset_id)
        Helper.request_to_read_data("#{URI_API}/#{asset_id}")
      end

      # Get cryptocurrency history price
      # @param [String] asset_id Asset id, for example, bitcoin
      # @param [Symbol] interval Select one from the list in TIME_INTERVAL or choose one of m1,m5,m15,m30,h1,h2,h6,h12,d1
      def cryptocurrency_history(asset_id, interval)
        Helper.request_to_read_data("#{URI_API}/#{asset_id}/history",
                                    interval: interval.is_a?(Symbol) ? TIME_INTERVAL[interval] : interval)
      end
    end
  end
end

Coincap::AssetsPrice.cryptocurrencies
