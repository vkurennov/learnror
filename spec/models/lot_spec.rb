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

  describe 'scopes' do
    describe 'ended_soon' do
      before do
        now = Time.now
        6.times do |i|
          Lot.create!(end_time: now + i.seconds)
        end
      end

      it 'returns lot which will be ended in less than or equal to 5 sec' do
        expect(Lot.ended_soon.count).to eq 4
      end

      it 'does not return ended lots' do
        lot = Lot.create(end_time: Time.now - 1.second)
        expect(Lot.ended_soon).to_not include(lot)
      end

      it 'does not return lot which end time is more than 5 sec' do
        lot = Lot.create(end_time: Time.now + 6.seconds)
        expect(Lot.ended_soon).to_not include(lot)
      end
    end
  end
end
