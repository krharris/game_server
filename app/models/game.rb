class Game < ActiveRecord::Base

  has_many :chats
  has_many :moves
  
  belongs_to :user1, :class_name => 'User', :foreign_key => 'user_id_1'
  belongs_to :user2, :class_name => 'User', :foreign_key => 'user_id_2'
  
end
