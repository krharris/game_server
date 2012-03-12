class SessionsController < ApplicationController
  
  respond_to :json
  
  # def new
  # end

  # Create a user session so the user's client only has to sign in once.
  def create
    user = User.authenticate(params[:email], params[:password])

    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      respond_with(flash)
    else
      sign_in user 
      response = { :name => user.name, :email => user.email, :id => user.id }
      respond_with(response)
    end
  end

  # Destroying the session is like signing out.
  def destroy
    sign_out
    
    flash.now[:success] = "User signed out."
    respond_with(flash)
  end
end
