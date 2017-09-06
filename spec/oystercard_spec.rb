require 'oystercard'

RSpec.describe Oystercard do

  describe 'oystercard initialisation' do
    it 'creates a wallet with £10' do
      some_money = 10
      new_card = Oystercard.new(some_money)
      expect(new_card.what_is_balance).to eq 10
    end
  end

  describe 'oystercard initializing with default balance' do
    it 'new cards have a £5 default balance from Balance.new' do
      expect(subject.what_is_balance).to eq Oystercard::DEFAULT_BALANCE
    end
  end

  describe '#top_up' do
    it 'increments balance by top up amount' do
      expect { subject.top_up(5) }.to change { subject.what_is_balance}.by 5
    end
    it 'raise error for exceeding max balance' do
      expect { subject.top_up(95) }.to raise_error "Exceed max balance: #{Balance::MAX_BALANCE}"
    end
    it 'raise error for exceeding max balance' do
      subject.top_up(35)
      expect { subject.top_up(70) }.to raise_error "Exceed max balance: #{Balance::MAX_BALANCE}"
    end
  end

  describe '#touch_in' do
    let(:station) { double 'station' }

    it 'fail if insufficient balance' do
      no_money_card = Oystercard.new(0)
      expect { no_money_card.touch_in }.to raise_error("Current balance less than minimum journey fee #{Oystercard::MIN_FEE}")
    end

  end

  describe '#touch_out' do
    let(:station) { double 'station' }

    it 'reduces balance by min journey fee' do
      subject.touch_in
      expect { subject.touch_out }.to change { subject.what_is_balance }.by(-described_class::MIN_FEE)
    end


  end

  describe '#journey_history' do
    let(:station_1) { double 'Station1' }
    let(:station_2) { double 'Station2' }

    it 'is an empty array for new cards' do
      expect(subject.journey_history_hash).to be_empty
    end

    it 'passes "touch in" and card-object to journey history' do
      ideal_state = { :touch_in => subject}
      subject.touch_in
      expect(subject.journey_history_hash).to eq ideal_state
    end

    it 'passes "touch out" and card-object to journey history' do
      ideal_state = { :touch_out => subject}
      subject.touch_out
      expect(subject.journey_history_hash).to eq ideal_state
    end

    it 'accesses a complete journey history' do
      ideal_state = {:touch_in => subject, :touch_out => subject}
      subject.touch_in
      subject.touch_out
      expect(subject.journey_history_hash).to eq ideal_state
    end


      describe 'fare' do
          it 'charges fare' do
            subject.touch_out
            expect(subject.fare :touch_in).to eq Oystercard::MIN_FEE
          end

          it 'charges penalty fare if exit with outstanding exit in history' do
            subject.touch_out
            expect{subject.touch_out}.to change { subject.what_is_balance }.by(-described_class::PENALTY_FARE)
          end

      end





    #
    # it "finds the Journey object's entrance in the journey history array" do
    #   subject.touch_in 'Station1'
    #   subject.touch_out 'Station2'
    #   expect(subject.journey_history[0].entry_station).to eq 'Station1'
    # end


  end
end
