class Api::V1::UsersController < Api::BaseController
  include UsersHelper

  before_action :authenticate_with_api_key

  def show
    #http://localhost:3000/api/v1/users/show?api=%@&email=%@
    #the request will replace %@ with the shortened link
    @user = User.find_by(email: params[:email])
    if @user.nil?
      render json: { errors: "No user exists with that email!" }
    else
      render json: {
                    name: @user.name,
                    email: @user.email,
                    links: @user.links,
                    }
    end
  end
end
