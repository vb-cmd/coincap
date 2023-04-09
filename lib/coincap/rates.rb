# frozen_string_literal: true

require_relative 'helper'

module Coincap
  # All prices on the CoinCap API are standardized in USD (United States Dollar).
  # To make translating to other values easy, CoinCap now offers a Rates endpoint.
  # We offer fiat and top cryptocurrency translated rates.
  # Fiat rates are available through OpenExchangeRates.org.
  module Rates
    URI_API = 'https://api.coincap.io/v2/rates'

    class << self
      # Returns a list of all rates.
      # @return [Hash]
      def list
        Helper.request_to_read_data(URI_API)
      end

      # Returns a single rate.
      # @param asset_id [String] The asset id (bitcoin)
      # @return [Hash]
      def single(asset_id)
        Helper.request_to_read_data("#{URI_API}/#{asset_id}")
      end
    end
  end
end
