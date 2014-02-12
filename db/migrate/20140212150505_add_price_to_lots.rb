class AddPriceToLots < ActiveRecord::Migration
  def change
    add_column :lots, :price, :float, default: 0
  end
end
