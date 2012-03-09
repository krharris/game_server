class UsersController < ApplicationController
  
  #before_filter :authenticate, :only => [:show, :edit, :update]
  
  respond_to :json
  
  def show
    @user = User.find(params[:id])
    respond_with(@user)
  end

  def new
# KRH: What's the differnce between new and create and do I need this at all?
    @user = User.new
  end
  
  def create
    @user = User.create( :name => params[:name], :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation] )
    
    if @user.valid?
      sign_in @user
      respond_with(@user)

      #render :json=> @user.as_json(:auth_token => @user.name, :email => @user.email), :status=>201
      #return
    else
      respond_with(@user.errors)
      #flash.now[:error] = "Invalid email/password combination."
      #flash.now[:blah] = "BLAH."
      #respond_with(flash)

      #render :json=> @user.errors, :status => 422
      #format.json { render json: @user.errors, status: 422 }
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
      flash.now[:succes] = "User updated."
      respond_with(flash)
    else
      #respond_with(@user.errors)
      flash.now[:error] = "User not updated."
      respond_with(flash)
    end
  end
  
  #def list
  #  @users = User.all
  #  respond_with(@users)
  #end
  
  private
  
  def authenticate
    if signed_in? == false
      flash.now[:error] = "User not logged in."
      respond_with(flash)
    end
  end

end
