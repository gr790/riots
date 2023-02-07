# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: riots/home_temp.proto

require 'google/protobuf'
require 'byebug'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("riots/home_temp.proto", :syntax => :proto3) do
    add_message "riots.home_temp.HomeTemp" do
      optional :temparature, :float, 1
      optional :humidity, :float, 2
    end
  end
end

module Riots
  module HomeTemp
    HomeTemp = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("riots.home_temp.HomeTemp").msgclass

    # This method will generate temparature and humidity using random number in range
    # This method will use by client to publish temp/humidity to broker
    def self.message
      byebug
      temp = get_temparature
      humi = get_humidity
      msg = HomeTemp.new(
              temparature: temp,
              humidity: humi
            )
      begin
        puts "Generated Message: #{msg}"
        encoded = HomeTemp.encode(msg)
      rescue => ex
        raise StandardError, "Not able to encode message: #{ex.message}"
      end
    end

    # Generate random temparature upto 120.00(Not Inclusive)
    def self.get_temparature
      rand(0.0..120.00).round(2)
    end

    # Generate random humidity upto 101.00(Not Inclusive)
    def self.get_humidity
      rand(0.0..101.00).round(2)
    end

    def self.receive(message)
      log = Rails.configuration.logger
      decoded = HomeTemp.decode(message)
      log.info { "I was hit in Riots Module with #{decoded}" }
    end
  end
end
