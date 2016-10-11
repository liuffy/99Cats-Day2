class SessionsController < ApplicationController

  def new
    #   # In SessionsController#new:
    # Render a form for the user to input their username and password.
  end

  def create
    # In SessionsController#create:
    # Verify the user_name/password.
    # Reset the User's session_token.
    # Update the session hash with the new session_token.
    # Redirect the user to the cats index page.
  end

end
