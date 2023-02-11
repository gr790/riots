require 'riots/processor/base'

class Riots::Processor::HomeCctv < Riots::Processor::Base
  def cctv(message)
    puts "I will handle cctv feedback"
  end
end
