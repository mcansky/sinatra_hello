require 'sinatra'
require 'haml'

class SimpleApp < Sinatra::Base

  get '/' do
    haml "%h3 Hello THE AWESOME World!"
  end

  get '/mu-c9478619-b3ea1fef-e218a7ee-09081759' do
    '42'
  end

end
