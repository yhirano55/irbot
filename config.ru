require_relative 'lib/app'
run Rack::URLMap.new('/' => App, '/sidekiq' => Sidekiq::Web)
