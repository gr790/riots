require 'riots/subscriber'

module Riots::Processor
  class Base
    def initialize
      @worker = Riots::Subscriber.instance.client
    end

    # Main Listener for MQTT message
    def process
      @worker.get do|topic, message|
        temp(message) if topic.match(/temp/)
        cctv(message) if topic.match(/cctv/)
      end
    end
  end
end
