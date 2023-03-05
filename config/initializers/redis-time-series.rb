require 'redis'
require 'redis-time-series'

Redis::TimeSeries.redis = Redis.new(:host => "192.168.56.104", :port => 6379, :password => 'sekrit')
