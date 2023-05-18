# frozen_string_literal: true

require 'uri'
require 'json'
require 'net/http'
require 'openssl'

module Coincap
  # Helper module
  module Helper
    class << self
      # Request to read data
      # @param uri_string [String] string of the uri
      # @param queries_hash [Hash] queries hash for the request
      # @return [String]
      def request_to_read_data(uri_string, **queries_hash)
        http_get convert_hash_to_uri(uri_string, **queries_hash)
      end

      JSON.parse(data_str)
    end

    class << self
      private

      def http_get(uri)
        config = Coincap.instance_variable_get(:@config)

        headers = {
          'Accept-Encoding': config.accept_encoding.nil? ? nil : config.accept_encoding,
          'Authorization': config.api_key.nil? ? nil : "Bearer #{config.api_key}"
        }.compact

        Net::HTTP.get(uri, headers)
      end

      def convert_hash_to_uri(uri, **queries_hash)
        queries_str = queries_hash.compact.map { |key, value| "#{key}=#{value}" }.join('&')
        URI("#{uri}#{queries_str.empty? ? '' : "?#{queries_str}"}")
      end
    end
  end
end
