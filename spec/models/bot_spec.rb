require 'spec_helper'
Sidekiq::Testing.inline!

describe Bot do
  describe '.make_bet' do
    let(:lot) { Lot.create }
    let!(:user) { User.create!(email: 'test@user.com', password: '12345678', password_confirmation: '12345678', bot: false) }
    let!(:bot) { User.create!(email: 'bot@user.com', password: '12345678', password_confirmation: '12345678', bot: true) }

    before do
      allow(lot).to receive(:active?).and_return(true)
    end

    it 'creates bet for give lot' do
      expect { Bot.make_bet(lot) }.to change(lot.bets, :count)
    end

    it 'uses only bot users' do
      User.delete_all
      user
      expect { Bot.make_bet(lot) }.to_not change(lot.bets, :count)
    end

    it 'does not create bet if last bet for lot made by another bot' do
      Bet.create!(lot: lot, user: bot)
      expect { Bot.make_bet(lot) }.to_not change(lot.bets, :count)
    end

    it 'creates bet with random bot user' do
      bot2 = User.create!(email: 'bot2@user.com', password: '12345678', password_confirmation: '12345678', bot: true)
      expect(User).to receive(:random_bot).and_return(bot, bot2)
      Bot.make_bet(lot)
      Bet.create!(lot: lot, user: user)
      Bot.make_bet(lot)

      expect(lot.bets.first.user).to_not eq(lot.bets.last.user)
    end
  end

  describe '#perform' do
    before do
      @lots = []
      5.times { |i| @lots << Lot.create(title: "Lot #{i}") }
      @bot = Bot.new
    end

    after do
      @bot.perform
    end

    it 'calls make_bet method for ended soon lots' do
      allow(Lot).to receive(:ended_soon).and_return(@lots)
      @lots.each do |lot|
        expect(Bot).to receive(:make_bet).with(lot)
      end
    end

    it 'does not call make_bet method for non ended soon lots' do
      allow(Lot).to receive(:ended_soon).and_return([@lots.first])
      @lots[1..-1].each do |lot|
        expect(Bot).to_not receive(:make_bet).with(lot)
      end
    end
  end
end