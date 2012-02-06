class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.integer :user_id
      t.integer :game_id
      t.text :message

      t.timestamps
    end
  end
end
