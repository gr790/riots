require 'riots/processor/base'
require 'byebug'

module Riots::Processor
  class HomeTemp < Riots::Processor::Base

    def work(request)
      byebug
      puts "#{self.class} was hit"
      message = request.body.read
      puts "Message received: #{message.inspect}"
      topic = message["topic"]
      topic.gsub!("/","_")
      temp = message["temparature"]
      humidity = message["humidity"]
      Rails.cache.write(message, topic, expires_in: 3600)
      
    end
  end

end
