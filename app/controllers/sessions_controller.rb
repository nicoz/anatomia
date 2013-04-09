# @author Nicolas Zuasti
class SessionsController < ApplicationController
  # This method will just render the "new" view in a blank state
  # @return [nil] Will never return a value
  def new
  end
  
  # Authenticates the user passed by params.
  # If the User is correct, it gets saved into the session variable.
  # @return [Integer, nil] the user id logged or nil if the User is invalid
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end
  
  # Clears the information held in the session global variable
  # logging out the user and redirecting it to the root path
  # @return [nil] will always returns nil
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
  
end
