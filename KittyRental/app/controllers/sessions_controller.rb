class SessionsController < ApplicationController
  before_action :require_no_user!, only: [:create, :new]

  def new
    #   # In SessionsController#new:
    # Render a form for the user to input their username and password.
    render :new
  end

  def create
    @user = User.find_by_credentials(
    params[:user][:username],
    params[:user][:password]
  )

    if @user.nil?
      flash[:errors] = ["Incorrect username and/or password"]
      redirect_to new_session_url
    else
      log_in!(@user)
      @user.reset_session_token! # Reset the User's session_token.
      redirect_to cats_url   # Redirect the user to the cats index page.
    end
  end

  def destroy # Use current_user to implement SessionsController#destroy.
    current_user.session_token = nil
    log_out!
    redirect_to new_session_url
  end


end
