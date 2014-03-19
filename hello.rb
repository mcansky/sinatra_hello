require 'sinatra'
require 'haml'

class SimpleApp < Sinatra::Base

  get '/' do
    haml "%h3 Hello THE AWESOME World!"
  end

end
