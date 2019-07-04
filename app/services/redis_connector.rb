# frozen_string_literal: true

class RedisConnector

  def initialize
  end

  def init_redis
    if Rails.env.production? || Rails.env.staging?
      configure_sidekiq(ENV['REDIS_URL'])
      # $redis = Redis.new(url: ENV['REDIS_URL'])
    else
      host = 'localhost'
      port = '6379'
      url = "redis://#{host}:#{port}"
      configure_sidekiq(url)
      $redis = Redis.new(host: host, port: port)
    end
  end

  private

  def configure_sidekiq(url)
    %w[server client].each do |side|
      Sidekiq.send("configure_#{side}") do |config|
        config.redis = { url: url }
      end
    end
  end
end
