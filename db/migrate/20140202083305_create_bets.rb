class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.references :lot, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
