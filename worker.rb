require 'sinatra'
require 'sidekiq'
require 'redis'
require 'sidekiq/api'

$redis = Redis.new(url: ENV['REDIS_URL'])

class SinatraWorker
  include Sidekiq::Worker

  def perform(msg="lulz you forgot a msg!")
    sleep 2 + rand(10)
    $redis.lpush("sinkiq-example-messages", msg)
  end
end
