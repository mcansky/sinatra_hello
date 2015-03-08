class TestJob
  include Sidekiq::Worker

  def perform
    sleep 5
    MyRedis.redis.incr('blob1')
  end
end
