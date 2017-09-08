require 'journey'
require 'station'
require 'oystercard'

RSpec.describe Journey do
  describe '#journey_history' do
    let(:station_1) { double 'Station1' }
    let(:station_2) { double 'Station2' }
    let(:oystercard) { double Oystercard.new }

    # expect(when you touch in, a Journey object is created, with default values of nil for Entrance and Exit, and these overwritten with the Station you touched in or out of)
    #
    # Journey has @entry = station1
    # Journey has @exit = station2
    #
    # end

    it 'registers barrier pass' do
      expect(subject.exit_station). to eq nil
    end

    # it 'passes "touchin" and "Station1" to new instance of journey' do
    #   subject("Station1")
    #   expect(subject.entrance). to eq "Station1"
    # end
    #
    #
    # it 'creates a journey with entrance of nil' do
    #   subject.new("Station2")
    #   expect(subject.entrance). to eq "Station2"
    # end
  end
end
