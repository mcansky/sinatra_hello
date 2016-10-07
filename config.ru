require './hello'
run Rack::URLMap.new('/' => SimpleApp)
