require 'redis-time-series'
require 'singleton'

module Riots
  class TimeSeries
    include Singleton

    def initialize
      @temp = Redis::TimeSeries.new('temperature:room')
      @humidity = Redis::TimeSeries.new('humidity:room')
    end

    def update(temp, humidity)
      add_temp(temp)
      add_hum(humidity)
    end


    def add_temp(data)
        @temp.add data
    end

    def add_hum(data)
        @humidity.add data
    end

  end
end

