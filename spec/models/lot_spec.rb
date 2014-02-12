require 'spec_helper'

describe Lot do
  let(:lot) { Lot.new }

  describe "#increase_price" do
    it 'increases price' do
      expect { lot.increase_price }.to change(lot, :price).by(1)
    end

    it 'saves changed price' do
      expect(lot.price).to eq(0)
      lot.increase_price
      lot.reload
      expect(lot.price).to eq(1)
    end
  end

  it '#increase_price' do
    pending
   end

  it '#increase_end_time' do
    pending
  end

  it '#active?' do
    pending
  end
end
