class Api::V1::LinksController < Api::BaseController
  include LinksHelper

  before_action :authenticate_with_api_key

  def create
    param = { long_url: params[:url] }
    @link = @user.links.build(param)
    if @link.save
      render json: { shorturl: full_url(@link) }
    else
      render json: { errors: @link.errors }
    end
  end

  def show
    #http://localhost:3000/api/v1/links/show?api=%@&url=%@
    #the request will replace %@ with the shortened link
    @link = Link.find_by(short_url: params[:url])
    if @link.nil?
      render json: { errors: "That short_url doesn't exist!" }
    else
      render json: {
                    short_url: @link.short_url,
                    long_url: @link.long_url,
                    clicks: @link.clicks,
                    user: { name: @link.user.name, email: @link.user.email }
                    }
    end
  end
end
