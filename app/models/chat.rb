class Chat < ActiveRecord::Base
  
  belongs_to :game
  belongs_to :user
  
  attr_accessible :user_id, :game_id, :message
  
end
