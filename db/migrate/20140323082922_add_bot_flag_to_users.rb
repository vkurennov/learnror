class AddBotFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bot, :boolean, default: false
    add_index :users, :bot
  end
end
