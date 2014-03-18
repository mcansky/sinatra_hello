require 'sinatra'

class SimpleApp < Sinatra::Base

  get '/' do
    "Hello THE AWESOME World!"
  end

end
