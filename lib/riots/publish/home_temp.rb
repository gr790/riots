require 'yaml'
require 'active_support/core_ext/hash/keys'
require 'riots/home_temp_pb'
require 'byebug'

module Riots
  module HomeTemp
    module Publish
      def self.start
        cfg = YAML.load_file('/opt/riots/config/riots.yml').deep_symbolize_keys
        cfg = cfg[:production]
        host = cfg[:mqtt][:host]
        port = cfg[:mqtt][:port]
        begin
          client = MQTT::Client.connect(:host => host, :port => port)
          topics = cfg[:topics]
          topics.each do |topic|
            # Publish temparature/humidity on temp topic only
            if topic.match(/temp/)
              msg = Riots::HomeTemp.message
              client.publish(topic, msg, retain=false, qos=1)
            end
          end
        rescue => ex
          puts "Failed to connect #{host}:#{port} or Publish message: #{ex.message}"
          exit(1)
        end
      end

    end
  end
end
