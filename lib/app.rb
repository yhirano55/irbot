require 'bundler/setup'
Bundler.require

require_relative 'worker'

class App < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :server, :puma

  configure :production, :development do
    enable :logging
  end

  get '/' do
    Worker.perform_async(params)
    response.status.to_s
  end
end
