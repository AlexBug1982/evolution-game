if !Rails.env.test?
  RedisConnector.new.init_redis
end
