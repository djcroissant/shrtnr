class LinksController < ApplicationController
  include LinksHelper
  include SessionsHelper

  before_action :find_link, only: [:show, :redirection]

  def create
    url = Link.find_by_long_url(params[:link][:long_url])

    if url.blank?  #i.e. url DID NOT already exists in Link model
      if signed_in?
        @link = current_user.links.build(link_params)
      else
        @link = Link.new(link_params)
      end
    else  #i.e. url DID already exist
      if signed_in?
        flash[:error] = "This link already exists"
        redirect_to root_path and return
      else
        redirect_to link_path(url.short_url)
        return
      end
    end

    if @link.save
      redirect_to link_path(@link.short_url), notice: "URL added"
    else
      flash[:error] = "Your URL was not valid"
      redirect_to root_path
    end
  end

  def show
  end

  def redirection
    @link.clicks += 1
    @link.save
    redirect_to @link.long_url
  end

  private

    def find_link
      @link = Link.find_by_short_url(params[:id])
    end

    def link_params
      params.require(:link).permit(:long_url)
    end
end
