class TestJob
  include Sidekiq::Worker

  def perform
    MyRedis.redis.incr('blob1')
  end
end
