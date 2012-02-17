class SessionsController < ApplicationController
  
  respond_to :json
  
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])

    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      respond_with(flash)
    else
      sign_in user
      respond_with(user)
    end
  end

  def destroy
    sign_out
  end
end
