require 'sinatra'
require 'sidekiq'
require 'redis'
require 'sidekiq/api'
require 'haml'

class SimpleApp < Sinatra::Base

  get '/' do
    haml "%h3 Hello World!"
  end

end
