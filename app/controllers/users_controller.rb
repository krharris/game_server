class UsersController < ApplicationController
  
  # User must be logged in and have an active session to perform these operations.
  before_filter :authenticate, :only => [:show, :games, :usersPlayed, :moves, :chats]

  respond_to :json

# KRH: What's the differnce between new and create and do I need this at all?
  # def new
  #   @user = User.new
  # end

  def create
    @user = User.create( :name => params[:name], :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation] )
    
    if @user.valid?
      sign_in @user
      response = { :name => @user.name, :email => @user.email, :id => @user.id }
      respond_with(response)
    else
      #respond_with(@user.errors)
      flash.now[:error] = @user.errors
      respond_with(flash)
    end
  
  end

  def show

    @user = User.find_by_name(params[:name])

    if @user.nil?
      flash.now[:error] = "User doesn't exist."
      respond_with(flash)
    else
      response = { :user_id => @user.id }
      respond_with(response)
    end
    
  end

  def games
    # Find all the games where the passed user id is set as either user_id_1 or user_id_2.
    games = Game.find( :all, :conditions => ["user_id_1=? or user_id_2=?", params[:id], params[:id]] )

    response = Array.new

    games.each_with_index do |a, index|
      
      user1 = User.find_by_id( a.user_id_1.to_i )
      user2 = User.find_by_id( a.user_id_2.to_i )
      
      if user1.nil? or user2.nil?
        next
      end
      
        dataHash = Hash.new
        dataHash[:id] = a.id
        dataHash[:user_id_1] = a.user_id_1
        dataHash[:user_name_1] = user1.name
        dataHash[:user_id_2] = a.user_id_2
        dataHash[:user_name_2] = user2.name
        dataHash[:num_moves] = a.num_moves
        dataHash[:num_chats] = a.num_chats
        response.push( dataHash )
        
    end
    
    respond_with( response )
  end

  def usersPlayed
    # Find all the games where the passed user id is set as either user_id_1 or user_id_2.
    games = Game.find( :all, :conditions => ["user_id_1=? or user_id_2=?", params[:id], params[:id]] )

    response = Array.new
    ids = Array.new

    # Send back a response containing the ids and names of all users that 
    # the logged in user has played at least once.
    games.each_with_index do |a, index|

      otherUserId = 0

      if params[:id].to_i == a.user_id_1
        otherUserId = a.user_id_2
      else
        otherUserId = a.user_id_1
      end
      
      # Have we already recorded this user?
      if ids.include?( otherUserId )
        next
      end

      # Record this user.
      ids.push( otherUserId )

      user = User.find_by_id( otherUserId )

      if user.nil?
        next
      else
        dataHash = Hash.new
        dataHash[:user_id] = otherUserId
        dataHash[:user_name] = user.name
        response.push( dataHash )
      end

    end
    
    respond_with( response )
  end
  
  def moves
    # Find all the moves that match the passed game_id.
    moves = Move.find( :all, :conditions => { :game_id => params[:id] } )

    response = Array.new( moves.length, 0 )
    
    moves.each_with_index do |a, index|

      response[index] = Hash.new
      response[index][:id] = a.id
      response[index][:game_id] = a.game_id
      response[index][:data] = a.data
      
    end
    
    respond_with( response )
  end

  def chats
    # Find all the chats that match the passed game_id.
    chats = Chat.find( :all, :conditions => { :game_id => params[:id] } )

    response = Array.new( chats.length, 0 )
    
    chats.each_with_index do |a, index|

      response[index] = Hash.new
      response[index][:id] = a.id
      response[index][:game_id] = a.game_id
      response[index][:user_id] = a.user_id
      response[index][:message] = a.message
      
    end
    
    respond_with( response )
  end
  
  # def edit
  #   @user = User.find(params[:id])
  #   respond_with(@user)
  # end
  
  # def update
  #   @user = User.find(params[:id])
  #   
  #   if @user.update_attributes( :name => params[:name], :password => params[:password], :password_confirmation => params[:password_confirmation] )
  #     #respond_with(@user)
  #     flash.now[:success] = "User was updated."
  #     respond_with(flash)
  #   else
  #     #respond_with(@user.errors)
  #     flash.now[:error] = "User was not updated."
  #     respond_with(flash)
  #   end
  # end
  
  #def list
  #  @users = User.all
  #  respond_with(@users)
  #end
  
  private
  
  # Is the user logged in or not?
  def authenticate
    if signed_in? == false
      flash.now[:error] = "User not logged in."
      respond_with(flash)
    end
  end

end
