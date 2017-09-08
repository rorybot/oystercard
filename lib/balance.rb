class Balance

  MAX_BALANCE = 90


  def initialize(balance)
    @current_balance = balance
  end

  def current_balance
    @current_balance
  end




  def change_balance(function, amount)
    if function == :add
      @current_balance += amount
    elsif function == :subtract
      @current_balance -= amount
    end
  end



end
