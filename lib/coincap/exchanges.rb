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
      # @return [Hash]
      def list
        Helper.request_to_read_data(URI_API)
      end

      # Returns a single exchange.
      # @param exchange_id [String]
      # @return [Hash]
      def single(exchange_id)
        Helper.request_to_read_data("#{URI_API}/#{exchange_id}")
      end
    end
  end
end
