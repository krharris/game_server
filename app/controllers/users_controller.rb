class UsersController < ApplicationController
  
  # User mst be logged in and have an active session to perform these operations.
  before_filter :authenticate, :only => [:show, :edit, :update]

  respond_to :json
  
  def show
    @user = User.find(params[:id])
    #respond_with(@user)
    response = { :name => @user.name, :email => @user.email, :id => @user.id }
    respond_with(response)
  end

  def new
# KRH: What's the differnce between new and create and do I need this at all?
    @user = User.new
  end

  def create
    @user = User.create( :name => params[:name], :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation] )
    
    if @user.valid?
      sign_in @user
      #respond_with(@user)
      flash.now[:success] = "User was created and signed in."
      respond_with(flash)
    else
      #respond_with(@user.errors)
      flash.now[:error] = @user.errors
      respond_with(flash)
    end
  
  end

  def edit
    @user = User.find(params[:id])
    respond_with(@user)
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes( :name => params[:name], :password => params[:password], :password_confirmation => params[:password_confirmation] )
      #respond_with(@user)
      flash.now[:success] = "User was updated."
      respond_with(flash)
    else
      #respond_with(@user.errors)
      flash.now[:error] = "User was not updated."
      respond_with(flash)
    end
  end
  
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
