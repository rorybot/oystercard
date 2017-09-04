require 'oystercard.rb'
require 'barrier.rb'

describe Barrier do
  subject(:barrier) { described_class.new }
  let(:oystercard) { Oystercard.new }

  context 'Barrier access' do
    it 'touches in at barrier' do
      oystercard_with_one_pound = Oystercard.new(2)
      expect(subject.touch_in(oystercard_with_one_pound)).to eq [oystercard_with_one_pound]
    end

    it 'touches out of barrier' do
      oystercard_with_one_pound = Oystercard.new(2)
      expect(subject.touch_out(oystercard_with_one_pound)).to eq oystercard_with_one_pound
    end

    it 'checks if oystercard is in journey from barrier' do
      oystercard_with_one_pound = Oystercard.new(2)
      barrier.touch_in(oystercard_with_one_pound)
      expect(subject.in_journey?(oystercard_with_one_pound)).to eq true
    end

    it 'denies access if balance is less than £1' do
      expect { subject.touch_in oystercard }.to raise_error 'Insufficient funds'
    end
  end
end
