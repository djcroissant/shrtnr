class SettingsController < ApplicationController
  include SessionsHelper

  before_action :authentication_required

  def index
    @settings = current_user
  end

  def update
    @settings = current_user
    if @settings.update_attributes(settings_params)
      respond_to :js
    else
      redirect_to settings_url, alert: "Failed to update settings"
    end
  end

  def regenerate_key
    current_user.generate_api_key
    current_user.save
    @updated_key = "http://shrtnr.com/api/v1/links/create?api_key=#{current_user.api_key}&url=%@"
    respond_to :js
  end

  private

    def settings_params
      params.require(:settings).permit(:name, :email)
    end
end
