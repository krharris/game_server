class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user_id_1
      t.integer :user_id_2
      t.integer :num_moves
      t.integer :num_chats

      t.timestamps
    end
  end
end
