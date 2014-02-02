class CreateLots < ActiveRecord::Migration
  def change
    create_table :lots do |t|
      t.string :title
      t.datetime :end_time

      t.timestamps
    end
  end
end
