class UsersController < ApplicationController
  
  respond_to :json
  
  def new
    @user = User.create(:name => params[:name], :email => params[:email])
    respond_with(@user)
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
