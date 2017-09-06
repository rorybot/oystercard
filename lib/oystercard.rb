require_relative 'journey'
require_relative 'balance'

#NEed to think about the interface through which Oystercard is being deployed... unless Oystercard is the interface... so that changes don't impact

class Oystercard
  attr_reader :balance, :this_card_journey_history
  MIN_FEE = 1
  DEFAULT_BALANCE = 5
  PENALTY_FARE = 6

  def initialize(balance=DEFAULT_BALANCE, journey_history = Journey.new)
    @balance = Balance.new(balance)
    @this_card_journey_history = journey_history
  end

  def top_up(amount)
    raise "Exceed max balance: #{Balance::MAX_BALANCE}" if (balance.change_balance(:add, amount)) > Balance::MAX_BALANCE

  end


  def touch_in
    raise "Current balance less than minimum journey fee #{MIN_FEE}" if what_is_balance < MIN_FEE
      journey_history_hash[:touch_in] = self
  end

  def touch_out
    # journey_history << create_a_journey(entry_station, exit_station)
    #  journey_history << Journey.new(entry_station, exit_station)
    @entry_station = nil
    balance.change_balance(:subtract, fare(:touch_out) )
    journey_history_hash[:touch_out] = self
  end

  def create_a_journey(entry_station, exit_station)
    Journey.new(entry_station, exit_station)
  end

  def journey_history_hash
    this_card_journey_history.journey_history
  end

  def what_is_balance
    balance.current_balance
  end


  def fare(current_status)
    if last_barrier_status_equals(current_status)
      PENALTY_FARE
    else
      MIN_FEE
    end
  end

  def last_barrier_status_equals(current_status)
    journey_history_hash.keys.last == (current_status)
  end

  private

  def in_journey?
    !!@entry_station
  end



end
