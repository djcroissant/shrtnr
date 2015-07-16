class LinksController < ApplicationController
  include LinksHelper
  include SessionsHelper

  before_action :find_link, only: [:show, :redirection]

  def create
    url = Link.find_by_long_url(params[:link][:long_url])

    if url.blank? #i.e. url DID NOT already exist in :link model
      if signed_in?
        @link = current_user.links.build(link_params)
      else
        @link = Link.new(link_params)
      end
    else  #i.e. url DID already exist in :link model
      if signed_in?
        #changed the following so that a new link isn't made each
        #time the same user shortens the same link.
        #A preferable fix would be to update the associations to
        #HABTM so that all users that shorten a long_url use
        #the same short_url.
        if current_user.links.where(long_url: url.long_url).exists?
          redirect_to link_path(url.short_url)
          return
        else
          @link = current_user.links.build(link_params)
        end
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
