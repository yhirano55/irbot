require 'sidekiq'

redis_host = ENV.fetch('REDIS_HOST', 'localhost')
redis_port = ENV.fetch('REDIS_PORT', 6379)
redis_url = "redis://#{redis_host}:#{redis_port}".freeze

$redis = Redis.new( url: redis_url )
Sidekiq.configure_server { |config| config.redis = { url: redis_url } }
Sidekiq.configure_client { |config| config.redis = { url: redis_url } }

class Worker
  include Sidekiq::Worker

  def perform(params = {})
    logger.info params
  end
end
