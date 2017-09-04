class Oystercard
  attr_reader :balance
  MAX_BALANCE = 90

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(money)
    fail "I'm too full of money - I can only take £#{MAX_BALANCE}!" if @balance + money > MAX_BALANCE
    @balance += money
  end

  def deduct(money)
    #fail "I'm too full of money - I can only take £#{MAX_BALANCE}!" if
    #@balance + money > MAX_BALANCE
    @balance -= money
  end

end
