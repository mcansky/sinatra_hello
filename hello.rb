require 'sinatra'
require 'haml'
require 'sidekiq'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] || 'redis://localhost:6379/1', namespace: 'sidekiq' }
end

class MyRedis
  def self.redis
    @@redis ||= Redis.new(url: ENV['REDIS_URL'] || 'redis://localhost:6379/1' )
    @@redis.set('blob', '200000000000000000000000')
    @@redis
  end

  def self.value
    MyRedis.redis.get('blob')
  end
end

class SimpleApp < Sinatra::Base

  get '/' do
    haml "%h3 Hello THE BEANSTALK AWESOME World! #{MyRedis.value}"
  end

  get '/mu-c9478619-b3ea1fef-e218a7ee-09081759' do
    '42'
  end

end
