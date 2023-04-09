# frozen_string_literal: true

require 'uri'
require 'json'
require 'net/http'
require 'openssl'

module Coincap
  # Helper module
  module Helper
    class << self
      def request_to_read_data(uri, **queries_hash)
        str_queries = queries_hash.compact.map { |key, value| "#{key}=#{value}" }.join('&')
        uri = URI("#{uri}#{queries_hash.empty? ? '' : "?#{str_queries}"}")
        data_str = Net::HTTP.get(uri)
        JSON.parse(data_str)
      end
    end
  end
end
