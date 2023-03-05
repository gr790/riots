require 'riots/processor'
require 'riots/stats'

class RiotsController < ActionController::Base
    skip_before_action :verify_authenticity_token
    protect_from_forgery except: :home_stats

    def home_stats
        begin
          puts "Controller was hit from riots-logstash"
          Riots::Stats.instance.inc "network.request.iots.received"
          Riots::Processor::HomeTemp.new.work(request)
        ensure
            render :json => {status: 200}
        end
    end

end
