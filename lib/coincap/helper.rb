# frozen_string_literal: true

require 'uri'
require 'json'
require 'net/http'
require 'openssl'

module Coincap
  BASE_URI = 'https://api.coincap.io/'
  VERSION_API = 'v2'

  # Helper module
  module Helper
    class << self
      # Request to read data
      #
      # @param uri_string [String] String of the uri
      # @param queries_hash [Hash] Queries hash for the request
      # @return [String]
      def request_to_read_data(uri_string, **queries_hash)
        http_get build_uri(uri_string, **queries_hash)
      end

      private

      def http_get(uri)
        config = Coincap.config

        headers = {
          'Accept-Encoding': config.accept_encoding,
          'Authorization': config.api_key.nil? ? nil : "Bearer #{config.api_key}"
        }.compact

        Net::HTTP.get(uri, headers)
      end

      def build_uri(uri, **queries_hash)
        queries_str = queries_hash.compact.map { |key, value| "#{key}=#{value}" }.join('&')
        URI("#{uri}#{queries_str.empty? ? '' : "?#{queries_str}"}")
      end
    end
  end
end
