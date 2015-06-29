class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    unless user_params[:email] =~ /^.+@.+$/
      flash[:alert] = 'Invalid Email'
      render new_user_path and return
    end

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "You have signed up"
    else
      flash[:alert] = 'Error, Try Again'
      render "new"
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
