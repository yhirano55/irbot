require 'bundler/setup'
Bundler.require

require_relative 'worker'
require_relative 'runner'
require_relative 'twitter_api'

class App < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :server, :puma

  configure :production, :development do
    enable :logging
  end

  SEARCH_WORD = '#rubyinterpreter2017'.freeze

  post '/' do
    username = format_username(params[:username])
    text = format_text(params[:text])
    Worker.perform_async(username: username, text: text)
    message = format('@%{username} %{status}', username: username, status: response.status.to_s)
    TwitterApi.update(message)
  end

  private

  def format_username(value)
    value.to_s.strip
  end

  def format_text(value)
    value.to_s.gsub(/#{SEARCH_WORD}/, '').strip
  end
end
