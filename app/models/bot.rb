class Bot
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { secondly(1) }

  def self.make_bet(lot)
    last_bet = lot.bets.last
    Bet.create(lot: lot, user: User.random_bot) if !last_bet.present? || !last_bet.user.bot?
  end

  def perform
    Lot.ended_soon.each { |lot| Bot.delay.make_bet(lot) }
  end
end