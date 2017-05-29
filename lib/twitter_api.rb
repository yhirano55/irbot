require 'twitter'

module TwitterApi
  class << self
    def client
      @_client ||= Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["CONSUMER_KEY"]
        config.consumer_secret     = ENV["CONSUMER_SECRET"]
        config.access_token        = ENV["ACCESS_TOKEN"]
        config.access_token_secret = ENV["ACCESS_SECRET"]
      end
    end

    def respond_to_missing?(method, include_private = false)
      client.respond_to?(method, include_private) || super
    end

    private

    def method_missing(method, *args, &block)
      return super unless client.respond_to?(method)
      client.public_send(method, *args, &block)
    end
  end
end
