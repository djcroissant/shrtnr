class SessionsController < ApplicationController
  include SessionsHelper

  def direct
    if signed_in?
      redirect_to dashboard_path
    else
      redirect_to home_path
    end
  end

  def new
  end

  def create
    user = User.where(email: params[:email]).first

    if user && params[:password].present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:provider] = user.provider
      redirect_to dashboard_path, notice: "You have been logged in."
    else
      flash[:error] = "Your username or password are incorrect. Please try again."
      redirect_to login_url
    end
  end

  def twitter
    # raise request.env["omniauth.auth"].to_yaml
    auth = request.env["omniauth.auth"]
    if session[:user_id].nil?  #user is not currently logged in.
      user = User.where(uid: auth["uid"]).first || User.from_twitter(auth)
      session[:user_id] = user.id  #Note:  user.id & user.uid are different.  uid = twitter
      flash[:notice] = "You have been logged in through Twitter."
      redirect_back_or root_url
    elsif User.where(uid: auth["uid"]).empty? || session[:user_id] == User.where(uid: auth["uid"]).first.id
      #Either no Twitter account already existed OR
      #user is logged in & the Twitter account was already linked to the current session id
      #overwrite current user info with what is in Twitter account
      user = User.where(id: session[:user_id]).first
      user.name = auth.info.name
      user.uid = auth.uid
      user.provider = auth.provider
      user.save
      flash[:notice] = "Your account details have been synced with Twitter."
      redirect_back_or root_url
    else
      #Twitter id exists, but it is not the current user
      #merge data and merge saved links
      #should add a pop up in the case that current account has a twitter asscn, but
      #asscn is different from what user just authenticated

      current_user = User.where(id: session[:user_id]).first
      twitter_user = User.where(uid: auth["uid"]).first
      current_user.name = twitter_user.name
      current_user.uid = twitter_user.uid
      current_user.provider = twitter_user.provider
      current_user.save
      twitter_user.links.each { |l| l.update user_id: current_user.id }
      User.where(uid: twitter_user.uid).first.destroy
      flash[:notice] = "Twitter account already existed.  Current logged in account has been synced with existing Twitter account."
      redirect_back_or root_url
    end
  end

  def failure
    flash[:alert] = "Authentication Failed"
    redirect_back_or root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "You have been logged out."
  end
end


#Do I need to have something like this?
# def auth_hash
#   request.env['omniauth.auth']
# end
