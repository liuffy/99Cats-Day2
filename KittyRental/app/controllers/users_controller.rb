class UsersController < ApplicationController
  before_action :require_no_user!, except: [:create, :new]

  def new
    # present form for signup
    @user = User.new
    render :new
  end

  def create
    # sign up the user
    @user = User.new(user_params)
    if @user.save
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
