require 'oystercard.rb'
require 'barrier.rb'

describe Barrier do
  subject(:barrier) { described_class.new }
  let (:oystercard) { Oystercard.new }
  let (:oystercard_with_two_pound) { Oystercard.new(2)}

  context 'Barrier access' do
    it 'touches in at barrier' do
      expect(subject.touch_in(oystercard_with_two_pound)).to eq [oystercard_with_two_pound]
    end

    it 'touches out of barrier' do
      expect(subject.touch_out(oystercard_with_two_pound)).to eq nil
    end


    it 'denies access if balance is less than £1' do
      expect { subject.touch_in oystercard }.to raise_error 'Insufficient funds'
    end

    it 'deducts from balance when #touch_out' do
      expect {subject.touch_out oystercard_with_two_pound}.to change{oystercard_with_two_pound.balance}.by(-Oystercard::MIN_BALANCE)
    end
  end


  context 'Journey tracking' do
    it 'cards remember touched in at station' do
      subject.touch_in(oystercard_with_two_pound)
       expect(subject.station).to include(oystercard_with_two_pound)
    end

    it 'cards remember touched out at station' do
      subject.touch_in(oystercard_with_two_pound)
      subject.touch_out(oystercard_with_two_pound)
       expect(subject.station).to_not include(oystercard_with_two_pound)
    end
  end
end
