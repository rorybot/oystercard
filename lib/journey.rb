
class Journey
  attr_reader :entry_station, :exit_station, :journey_history, :stored_journey_history

  def initialize
    @entry_station
    @exit_station
    @journey_history = { 'touch_in' => 'no_data', 'touch_out' => 'no_data', 'journey_number' => 1234 }
    @stored_journey_history = []
  end


  # if new key matches old key
  #
  #   or hash is empty before adding touch out
  #
  #   then fare
  #
end
