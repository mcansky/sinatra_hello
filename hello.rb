require 'sinatra'
require 'sidekiq'
require 'redis'
require 'sidekiq/api'
require 'haml'

$redis = Redis.new

class SimpleApp < Sinatra::Base

  get '/' do
    SinatraWorker.perform_async(msg="beanstalk was pulled")
    haml "%h3 Hello THE BEANSTALK AWESOME World!"
  end

  get '/stats' do
    stats = Sidekiq::Stats.new
    @failed = stats.failed
    @processed = stats.processed
    @messages = $redis.lrange('sinkiq-example-messages', 0, -1)
    erb :index
  end

  get '/mu-c9478619-b3ea1fef-e218a7ee-09081759' do
    '42'
  end

end
