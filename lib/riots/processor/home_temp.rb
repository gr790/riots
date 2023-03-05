require 'riots/processor/base'
require 'riots/redis'
require 'byebug'

module Riots::Processor
  class HomeTemp < Riots::Processor::Base

    def work(request)
      redis_ts = Riots::TimeSeries.instance
      byebug
      puts "#{self.class} was hit"
      message = request.body.read
      puts "Message received: #{message.inspect}"
      topic = message["topic"]
      topic.gsub!("/","_")
      temp = message["temparature"]
      humidity = message["humidity"]
      redis_ts.update(temp, humidity)
    end
  end

end
