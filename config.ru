require './hello'
require 'sidekiq/web'
run Rack::URLMap.new('/' => SimpleApp, '/sidekiq' => Sidekiq::Web)
