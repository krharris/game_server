class UsersController < ApplicationController
  
  respond_to :json
  
  def new
    
# KRH: What's the differnce between new and create?

    #raise params[:user].inspect # Note: :user is the form's name.
    
    # @user = User.new( :name => params[:name], :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation] )
    # 
    # if @user.save
    #   respond_with(@user)
    # else
    #   respond_with(@user.errors)
    # end
    
  end
  
  def create
    @user = User.create( :name => params[:name], :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation] )
    
    if @user.valid?
      sign_in @user
      respond_with(@user)
    else
      #flash.now[:error] = "Invalid email/password combination."
      respond_with(@user.errors)
    end
    
  end

  def list
    @users = User.all
    respond_with(@users)
  end
  
  def show
    @user = User.find(params[:id])
    respond_with(@user)
  end
end
