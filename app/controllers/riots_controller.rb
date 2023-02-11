require 'riots/processor'

class RiotsController < ActionController::Base
    skip_before_action :verify_authenticity_token
    protect_from_forgery except: :home_stats

    def home_stats
        begin
          puts "Controller was hit from riots-logstash"
          Riots::Processor::HomeTemp.new.work(request)
        ensure
            # aligned with SOAP 1.2 spec
            render :json => {status: 200}
        end
    end

end
