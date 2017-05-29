require 'sidekiq'

require_relative 'runner'
require_relative 'twitter_api'

redis_host = ENV.fetch('REDIS_HOST', 'localhost')
redis_port = ENV.fetch('REDIS_PORT', 6379)
redis_url = "redis://#{redis_host}:#{redis_port}".freeze

$redis = Redis.new( url: redis_url )
Sidekiq.configure_server { |config| config.redis = { url: redis_url } }
Sidekiq.configure_client { |config| config.redis = { url: redis_url } }

class Worker
  include Sidekiq::Worker

  def perform(params = {})
    logger.debug(params)
    username = params['username']
    result   = Runner.execute(params['text'])
    message  = format('@%{username} %{result}', username: username, result: result)
    TwitterApi.update(message)
  end
end
