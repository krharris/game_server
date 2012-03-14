class GamesController < ApplicationController
  
      # User must be logged in and have an active session to perform these operations.
      before_filter :authenticate, :only => [:create, :show]

      respond_to :json

      def create

        game = Game.create(:user_id_1 => current_user.id, :user_id_2 => params[:opponent_id], :num_moves => 0, :num_chats => 0)

        if game.valid?
           response = { :id => game.id, :user_id_1 => game.user_id_1, :user_id_2 => game.user_id_2, :num_moves => game.num_moves, :num_chats => game.num_chats }
           respond_with(response)
        else
           flash.now[:error] = game.errors
           respond_with(flash)
        end

      end

      def show

        game = Game.find_by_id(params[:id])

        if game.nil?
          flash.now[:error] = "Game doesn't exist."
          respond_with(flash)
        else
          response = { :user_id_1 => game.user_id_1, :user_id_2 => game.user_id_2, :num_moves => game.num_moves, :num_chats => game.num_chats }
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
