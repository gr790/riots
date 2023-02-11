# frozen_string_literal: true

require 'mqtt'
require 'monitor'
require 'singleton'
require 'riots/home_temp_pb'
require 'byebug'

module Riots
    class Subscriber
        include Singleton

        attr_accessor :client

        def initialize
          @log = Rails.configuration.logger
          @client = nil
        end

        def start(_urls = [])
          @log.info {"starting mqtt subscriber"}
          byebug
          begin
            connect
            subscribe
            @log.info {"Finished subscribing MQTT Broker at #{Time.now}"}
          rescue StandardError => e
            @log.error {"Exception occurred while subscribing is: #{e.message}"}
          end
        end

        private

        def connect
            cfg = Rails.configuration.riots
            host = cfg[:mqtt][:host]
            port = cfg[:mqtt][:port]
            name = cfg[:mqtt][:name]
            begin
              @client = MQTT::Client.connect(:host => host, :port => port)
            rescue => ex
              msg = "Failed to connect #{name}:#{host}:#{port}"
              raise StandardError.new(msg)
            end
        end

        def subscribe
            cfg = Rails.configuration.riots
            topics = cfg[:topics]
            begin
              topics.each do |topic|
                @log.debug {"Subscribing to topic: #{topic}"}
                @client.subscribe(topic)
              end
            rescue => ex
              msg = "Failed to subscribe #{name}:#{host}:#{port}"
              raise StandardError.new(msg)
            end
        end

    end
end




