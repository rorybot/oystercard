require 'station'

RSpec.describe Station do
  describe '#initialize' do
    subject(:station) { described_class.new('Test Station 1', zone: 1) }

    it 'stores station name' do
      expect(station.name).to eq 'Test Station 1'
    end

    it 'stores station zone' do
      expect(station.zone).to eq 1
    end
  end
end
