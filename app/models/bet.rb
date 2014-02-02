class Bet < ActiveRecord::Base
  belongs_to :lot
  belongs_to :user

  after_create :increase_lot_end_time

  private

  def increase_lot_end_time
    self.lot.end_time += 30.seconds
    self.lot.save!
  end
end
