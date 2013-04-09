# @author Nicolas Zuasti
class UsersController < ApplicationController
  # Generates a new instance of the User class and 
  # sends it to the users/new view
  # @return [User] a blank instance of the User class
  def new
    @user = User.new
  end
  
  # Creates a new User instance and sets it up with 
  # the values passed by params. If the user validates it's 
  # saved to the database. If it's not the users/new view is rendered
  # again with the corresponding error messaged on display.
  # @param params[:user][:password] [String] String with the password to be encrypted
  # @param params[:user][:password_confirmation] [String] String with the confirmation of the password
  # @param params[:user][:email] [String] User email
  # @return [nil] Nothing returned
  def create
    # creates a new instance of User class
    @user = User.new(params[:user])

    # Attempts to save, if the validations checks the instance is saved
    # and the the application redirects to the root path
    if @user.save
      # Sends welcome email
      UserMailer.welcome_email(@user).deliver

      redirect_to root_url, :notice => "Signed Up!"
    else
      # If there are any validation errors the users/new view will
      # be rendered displaying them
      render "new"
    end
  end
end
