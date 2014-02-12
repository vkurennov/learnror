class Lot < ActiveRecord::Base
  has_many :bets

  def increase_price
  end

  def increase_end_time
  end

  def active?
  end
end
