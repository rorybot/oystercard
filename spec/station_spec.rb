require 'station'

RSpec.describe Station do
  describe '#initialize' do
    subject {Station.new('Test Station 1', zone: 1) }

    it 'stores station name' do
      expect(subject.name).to eq 'Test Station 1'
    end

    it 'stores station zone' do
      expect(subject.zone).to eq 1
    end
  end
end
