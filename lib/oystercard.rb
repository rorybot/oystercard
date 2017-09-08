require_relative 'journey'
require_relative 'balance'
require 'Time'

#NEed to think about the interface through which Oystercard is being deployed... unless Oystercard is the interface... so that changes don't impact

class Oystercard
  attr_reader :balance, :this_card_journey_history, :count_double_touch, :count_double_touch
  MIN_FEE = 1
  DEFAULT_BALANCE = 5
  PENALTY_FARE = 6

  def initialize(balance=DEFAULT_BALANCE, journey_history = Journey.new)
    @balance = Balance.new(balance)
    @this_card_journey_history = journey_history
    @count_double_touch = 0
  end

  def top_up(amount)
    raise "Exceed max balance: #{Balance::MAX_BALANCE}" if (balance.change_balance(:add, amount)) > Balance::MAX_BALANCE
    "You now have £#{what_is_balance}"
  end



  def touch_in
    raise "Current balance less than minimum journey fee #{MIN_FEE}" if what_is_balance < MIN_FEE
      # if in_journey?
      #   increment_double_touch(1)
      #   journey_history_hash["touch_in"] = :entry_station
      #     this_card_journey_history.stored_journey_history << journey_history_hash
      #     journey_history_hash['journey_number'] = rand
      # end

      # if count_double_touch > 0
      journey_history_hash["touch_in"] = :entry_station
        return "Touched in"

  end

  def new_journey_history
    this_card_journey_history = Journey.new
  end

  def touch_out
    journey_history_hash["touch_out"] = :exit_station
    balance.change_balance(:subtract, fare )
    increment_double_touch(-100) #resets-to-zero; not '0' in case that's needed
    # if in_journey? == false
    #   this_card_journey_history.stored_journey_history[-1]["touch_out"] = self
    # end
      this_card_journey_history.stored_journey_history << journey_history_hash
      journey_history_hash['journey_number'] = 5678

    return "Touched out"
  end

  # def create_a_journey(entry_station, exit_station)
  #   Journey.new(entry_station, exit_station)
  # end
  #Put this back in, so that it doesn't initisalise a new jouney history to start with, but just creates a new one which gets stuck into an array of hashes, and then it looks at that when reading


  #
  #
  # private

  def in_journey?
    journey_history_hash["touch_in"] != 'no_data' && journey_history_hash["touch_out"] == 'no_data'
  end

  def what_is_balance
    balance.current_balance
  end

  def journey_history_hash
    this_card_journey_history.journey_history
  end


  def increment_double_touch(argument)
    if argument == -100
      @count_double_touch = 0
    else
      @count_double_touch += argument
    end
  end

  def fare
    if in_journey? == false
      PENALTY_FARE
    elsif count_double_touch > 0
      PENALTY_FARE*count_double_touch
    else
      MIN_FEE
    end
  end



end
