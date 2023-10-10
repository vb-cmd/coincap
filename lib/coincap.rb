# frozen_string_literal: true

require_relative 'coincap/version'
require_relative 'coincap/assets_price'
require_relative 'coincap/helper'
require_relative 'coincap/markets'
require_relative 'coincap/rates'
require_relative 'coincap/exchanges'

# CoinCap 2.0 RESTful API is currently in production!
# The CoinCap team is excited to offer you new endpoints and more clarity on pricing!
#
# CoinCap 2.0 launched on September 26, 2018.
# Please let us know what you like, what you would hope to see, or any bugs/changes that you'd like to document.
#
# The easiest way to submit feedback to our team is to fill out a support ticket here.
# The old CoinCap API is deprecated and was shut down on March 1, 2019.
#
# For any issues with transitioning from the old CoinCap API to the new,
# please submit feedback via the zendesk link above!
module Coincap
  # Configuration class for Coincap
  class Configuration
    # @return [String] The API key to use for all requests.
    attr_accessor :api_key
    # @return [String] The accept encoding to use for all requests. Select 'gzip' or 'deflate'. Defaults to 'gzip'.
    attr_accessor :accept_encoding

    def initialize(api_key = nil, accept_encoding = 'gzip')
      @api_key = api_key
      @accept_encoding = accept_encoding
    end
  end

  class << self
    # Configuration the Coincap API
    # @return [Coincap::Configuration]
    def config
      @config ||= Configuration.new
    end

    # Configuration the Coincap API
    def self.configure
      yield config
    end
  end
end
