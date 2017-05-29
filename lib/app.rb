require 'bundler/setup'
Bundler.require

class App < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :server, :puma

  configure :production, :development do
    enable :logging
  end

  get '/' do
    response.status.to_s
  end
end
