class SessionsController < ApplicationController
  before_action :require_no_user!

  def new
    #   # In SessionsController#new:
    # Render a form for the user to input their username and password.
    render :new
  end

  def create
    user = User.find_by_credentials(session_params[:username], session_params[:password]) # verify username and password

    if user.nil?
      flash.now[:errors] = ["Incorrect username and/or password"]
      redirect_to new_session_url
    else
      login_user!(user)
      user.reset_session_token! # Reset the User's session_token.
      redirect_to cats_url   # Redirect the user to the cats index page.
    end
  end

  def destroy # Use current_user to implement SessionsController#destroy.
    current_user.session_token = nil
    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:user).permit(:username, :password)
  end

end
