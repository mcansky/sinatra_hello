require 'sinatra'

class SimpleApp < Sinatra::Base

  get '/' do
    "Hello World!"
  end

end
