require 'websocket-client-simple'

module Coincap
  class LiveAssets
    BASE_URI = 'wss://ws.coincap.io/prices?assets='

    # Initialize the websocket
    # @param assets [Array] List of assets
    def initialize(assets = 'ALL')
      @assets = assets
    end

    # Connect to the websocket
    def connect
      uri = "#{BASE_URI}#{@assets == 'ALL' ? @assets : @assets.join(',')}"
      @ws = WebSocket::Client::Simple.connect(uri)
    end

    # Close the websocket
    def disconnect
      @ws.close
    end

    # When receive the price
    def on_price(&on_message)
      @ws.on :message do |event|
        on_message.call(event.data)
      end
    end

    # When open the websocket
    def on_open(&on_open)
      @ws.on :open, &on_open
    end

    # When close the websocket
    def on_close(&on_close)
      @ws.on :close, &on_close
    end
    
    # When error
    def on_error(&on_error)
      @ws.on :error, &on_error
    end
  end
end
