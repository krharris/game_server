class Game < ActiveRecord::Base

  has_many :chats
  has_many :moves
  
  # Allow the two users known in the table as 'user_id_1' and 'user_id_2' to
  # be accessed as 'user1' and 'user2'.
  belongs_to :user1, :class_name => 'User', :foreign_key => 'user_id_1'
  belongs_to :user2, :class_name => 'User', :foreign_key => 'user_id_2'
  
end
