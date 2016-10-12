class ApplicationController < ActionController::Base
  # All of the controllers inherit from ApplicationController, so you can use these methods in any controller
  helper_method :current_user # Added so that current_user method is available to views
  helper_method :logged_in?
  protect_from_forgery with: :exception

  def require_no_user!
    redirect_to cats_url if current_user
  end

  def require_user!
    redirect_to new_session_url if current_user.nil?
  end

  def current_user # looks up the user with the current session token.
    return nil if session[:session_token].nil? # if there's no session token, there isn't a user yet
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def log_in!(user)
    @current_user = user
    session[:session_token] = user.session_token
    # storing the session token in the User, but we need to also store it in the session
  end

  def logged_in?
    return true unless current_user.nil?
  end

  def log_out!
    unless current_user.nil? # Unless there isn't a current_user
      current_user.reset_session_token! # Invalidate the old token so no one else can use it
      session[:session_token] = nil # Blank out :session_token in the session hash.
    end
  end


end
