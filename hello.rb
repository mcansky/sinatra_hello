require 'sinatra'
require 'haml'
require 'sidekiq'
require './workers/test_job'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] || 'redis://localhost:6379/1' }
end

class MyRedis
  def self.redis
    @@redis ||= Redis.new(url: ENV['REDIS_URL'] || 'redis://localhost:6379/1' )
    @@redis.incr('blob1')
    @@redis
  end

  def self.value
    MyRedis.redis.get('blob1')
  end
end

class SimpleApp < Sinatra::Base

  get '/' do
    10.times { TestJob.perform_async }
    haml "%h3 Hello THE BEANSTALK AWESOME World! #{MyRedis.value}"
  end

  get '/mu-c9478619-b3ea1fef-e218a7ee-09081759' do
    '42'
  end

end
