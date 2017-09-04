

class Barrier

  attr_reader :passed_barrier

  def initialize
    @passed_barrier = []
  end

  def touch_in(oystercard)
    raise 'Insufficient funds' if oystercard.balance <= Oystercard::MIN_BALANCE
    @passed_barrier << oystercard
  end

  def touch_out(oystercard)
    oystercard.deduct(Oystercard::MIN_BALANCE)
    passed_barrier.delete(oystercard)  
  end

  def in_journey?(oystercard)
    true if @passed_barrier.include?(oystercard)
  end


end
