require 'oystercard.rb'
require 'barrier.rb'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:barrier) { Barrier.new }

  context 'Balance management' do
    it '#zero_money_on_card_initialisation' do
      expect(oystercard.balance).to eq 0
    end

    it '#top_up balance of a card' do
      oystercard.top_up(1)
      expect(oystercard.balance).to eq 1
    end

    it '#deduct balance of a card' do
      oystercard_with_one_pound = Oystercard.new(1)
      oystercard_with_one_pound.deduct(1)
      expect(oystercard_with_one_pound.balance).to eq 0
    end

    it '#top_up raise exception if balance exceeds limit' do
      maximum_balance = Oystercard::MAX_BALANCE
      subject.top_up maximum_balance
      expect { subject.top_up 91 }.to raise_error "I'm too full of money - I can only take £90!"
    end
  end

  context 'Barrier access' do
    it 'touches in at barrier' do
      expect(barrier.touch_in(oystercard)).to eq [oystercard]
    end

    it 'touches out of barrier' do
      expect(barrier.touch_out(oystercard)).to eq oystercard
    end

    it 'checks if oystercard is in journey from barrier' do
      barrier.touch_in(oystercard)
      expect(barrier.in_journey? oystercard ).to eq true
    end
  end
end
