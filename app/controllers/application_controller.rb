# @author Nicolas Zuasti
class ApplicationController < ActionController::Base
  protect_from_forgery
  # This will make :current_user visible in views
  helper_method :current_user
  
  private
    # Instantiates the user that's been held 
    # in the session global variable.
    #
    # @return [User, nil] the User instance that corresponds to 
    # the session stored value or nil in case it's empty.
    def current_user
      # If session[:user_id] isn't nil @current_user is instantiated
      @current_user ||= User.find(session[:user_id]) if
        session[:user_id]
    end
end
