require 'riots/processor/base'

module Riots::Processor
  class HomeTemp < Riots::Processor::Base

    def temp(message)
        Riots::HomeTemp.receive(message)
    end
  end

end
