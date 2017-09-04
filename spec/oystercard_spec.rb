require 'oystercard.rb'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  it '#zero_money_on_card_initialisation' do
    expect(oystercard.balance).to eq 0
  end

  it '#top_up balance of a card' do
    oystercard.top_up(1)
    expect(oystercard.balance).to eq 1 
  end

end
