require 'oystercard.rb'

class Barrier

  def initialize
    @passed_barrier = []
  end

  def touch_in(oystercard)
    fail "Insufficient funds" if oystercard.balance <= 1
    @passed_barrier << oystercard
  end

  def touch_out(oystercard)
    touch_in(oystercard).delete(oystercard)
  end

  def in_journey?(oystercard)
    if @passed_barrier.include?(oystercard)
      true
    end
  end

end
