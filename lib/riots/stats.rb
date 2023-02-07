require 'statsd'
require 'singleton'

module Riots
    class Stats
        include Singleton

        def initialize
            cfg = Rails.configuration.riots
            @statsd = Statsd::Client.new cfg[:statsd][:host], cfg[:statsd][:port]
        end

        def inc(counter, by = 1)
            Rails.configuration.logger.debug "stats|c+: #{counter} #{by}"
            @statsd.increment(counter, by)
        end
    end
end
