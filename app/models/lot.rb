class Lot < ActiveRecord::Base
  has_many :bets

  def increase_price
    self.price += 1
    self.save!
  end

  def increase_end_time
  end

  def active?
  end
end
