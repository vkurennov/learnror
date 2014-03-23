class Lot < ActiveRecord::Base
  has_many :bets

  scope :ended_soon, -> { where("(end_time - now()) <= interval '5 sec' AND (end_time - now()) > interval '1 sec'") }

  def increase_price
    self.price += 1
    self.save!
  end

  def increase_end_time
  end

  def active?
  end
end
