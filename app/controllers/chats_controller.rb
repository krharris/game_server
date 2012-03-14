class ChatsController < ApplicationController
  
  # User must be logged in and have an active session to perform these operations.
  before_filter :authenticate, :only => [:create, :show]

  respond_to :json

  def create

    chat = Chat.create(:user_id => current_user.id, :game_id => params[:game_id], :message => params[:message])

    if chat.valid?
      
       game = Game.find_by_id( chat.game_id )

       if game.nil?
          flash.now[:error] = "Game associated with Chat doesn't exist."
          respond_with( flash )
       else
          game.num_chats += 1
          game.save()
       end

       response = { :user_id => chat.user_id, :game_id => chat.game_id, :message => chat.message }
       respond_with(response)
    else
       flash.now[:error] = chat.errors
       respond_with(flash)
    end

  end

  def show
    
    chat = Chat.find_by_id(params[:id])
    
    if chat.nil?
      flash.now[:error] = "Chat doesn't exist."
      respond_with(flash)
    else
      response = { :user_id => chat.user_id, :game_id => chat.game_id, :message => chat.message }
      respond_with(response)
    end
    
  end
      
  private

  # Is the user logged in or not?
  def authenticate
      if signed_in? == false
        flash.now[:error] = "User not logged in."
        respond_with(flash)
      end
  end
end
