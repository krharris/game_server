class MovesController < ApplicationController
  
    # User must be logged in and have an active session to perform these operations.
    before_filter :authenticate, :only => [:create, :show]

    respond_to :json

    def create

      move = Move.create(:user_id => current_user.id, :game_id => params[:game_id], :data => params[:data])

      if move.valid?
         response = { :user_id => move.user_id, :game_id => move.game_id, :data => move.data }
         respond_with(response)
      else
         flash.now[:error] = move.errors
         respond_with(flash)
      end

    end

    def show
      
      move = Move.find_by_id(params[:id])
      
      if move.nil?
        flash.now[:error] = "Move doesn't exist."
        respond_with(flash)
      else
        response = { :user_id => move.user_id, :game_id => move.game_id, :data => move.data }
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
