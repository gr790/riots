require 'riots/processor/base'
require 'redis'
require 'redis-time-series'
require 'byebug'

module Riots::Processor
  class HomeTemp < Riots::Processor::Base
   
    def work(request)
      puts "#{self.class} was hit"
      message = request.body.read
      puts "Message received: #{message.inspect}"
      arr = message.tr('"{','').tr('}"','').split(',').reject{|e| e=~/@timestamp/||e=~/@version/}
      data = arr.map { |i| i.split(':') }.to_h.transform_keys(&:to_sym)
      topic = data[:topic]
      topic.gsub!("/","_")
      # create the db connection
      create_db
      temp = data[:temperature].to_f.round(2).to_s.gsub('.','_')
      humidity = data[:humidity].to_f.round(1).to_s.gsub('.','_')
      Riots::Stats.instance.inc "home.temperature.#{temp}.received"
      Riots::Stats.instance.inc "home.humidity.#{humidity}.received"
      # write into db
      @temp_conn.add(temp)
      @humidity_conn.add(humidity)
    end

    def create_db
      if @humidity_conn.nil?
        @humidity_conn = Redis::TimeSeries.new('humidity:1')
      end
      if @temp_conn.nil?
        @temp_conn = Redis::TimeSeries.new('temperature:1')
      end
    end

  end

end
