require 'oystercard.rb'

class Barrier

  def initialize
    @passed_barrier = []
  end

  def touch_in(oystercard)
    @passed_barrier << oystercard
  end

  def touch_out(oystercard)
    touch_in(oystercard).delete(oystercard)
  end
end
