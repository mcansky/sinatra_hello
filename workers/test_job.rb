class TestJob
  include Sidekiq::Worker

  def perform
    sleep 2
    MyRedis.redis.incr('blob1')
  end
end
