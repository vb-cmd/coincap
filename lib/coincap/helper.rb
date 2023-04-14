# frozen_string_literal: true

require 'uri'
require 'json'
require 'net/http'
require 'openssl'

module Coincap
  # Helper module
  module Helper
    def self.request_to_read_data(uri_string, **queries_hash)
      uri = convert_hash_to_uri(uri_string, **queries_hash)

      data_str = http_get(uri)

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
