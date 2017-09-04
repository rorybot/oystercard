class Oystercard
  attr_reader :balance

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(new_money)
    @balance += new_money
  end

end
