require 'spec_helper'

describe Bet do
  let(:lot) { Lot.new }
  let(:bet) { Bet.new(lot: lot) }

  context 'when created' do
    before do
      allow(lot).to receive(:active?).and_return(true)
    end

    it "increases lot's price" do
      expect(lot).to receive(:increase_price)
      bet.save!
    end

    it "increases lot's end time" do
      expect(lot).to receive(:increase_end_time)
      bet.save!
    end
  end

  context 'validations' do
    it 'valid only for active lot' do
      allow(lot).to receive(:active?).and_return(true)
      expect(bet).to be_valid
    end

    it 'not valid if lot is not active' do
      allow(lot).to receive(:active?).and_return(false)
      expect(bet).to_not be_valid
    end
  end
end