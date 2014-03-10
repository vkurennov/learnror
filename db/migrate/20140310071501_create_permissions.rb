class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :title
      t.string :action
      t.string :subject
      t.integer :subject_id

      t.timestamps
    end
  end
end
