class Bet < ActiveRecord::Base
  belongs_to :lot
  belongs_to :user

  validates :lot, :user, presence: true
  #validate :lot_active?

  after_create :update_lot

  private

  def update_lot
    lot.increase_price
    lot.increase_end_time
  end

  def lot_active?
    errors.add(:lot, 'Lot is not active') unless lot.active?
  end
end
