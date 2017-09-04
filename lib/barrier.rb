

class Barrier

  attr_reader :station

  def initialize
    @station = []
  end

  def touch_in(oystercard)
    raise 'Insufficient funds' if oystercard.balance <= Oystercard::MIN_BALANCE
    @station << oystercard
  end

  def touch_out(oystercard)
    oystercard.deduct(Oystercard::MIN_BALANCE)
    station.delete(oystercard)
  end


end
