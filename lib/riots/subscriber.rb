# frozen_string_literal: true

require 'mqtt'
require 'monitor'
require 'singleton'
require 'riots/home_temp_pb'
require 'byebug'

module Riots
    class Subscriber
        include Singleton

        @@mutex = Monitor.new

        def initialize
                byebug
          @log = Rails.configuration.logger
        end

        def start(_urls = [])
          @log.info {"starting mqtt subscriber"}
          @@mutex.synchronize do
            Thread.new do
              begin
                cfg = Rails.configuration.riots
                # Define a private connect method which uses cfg object for host and port
                client = MQTT::Client.connect(:host => "127.0.0.1", :port => 1883)
                # Define a private method which iterates thru list of topics and subscribe to them
                # So that you don't need to write code for them
                client.subscribe("home/temp")
                @log.info {"Finished subscribing MQTT Broker at #{Time.now}"}
              rescue StandardError => e
                @log.error {"Exception occurred while subscribing is: #{e.message}"}
              end
              client.get do |topic, message|
                @log.debug { "#{topic} => #{message}" }
                Riots::HomeTemp.receive(message)
              end
            end
          end
        end
    end
end




