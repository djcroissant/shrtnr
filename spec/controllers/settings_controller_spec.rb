require 'spec_helper'

describe SettingsController do

  let(:user) { create(:user) }

  describe "#index" do
    context "when not signed in" do
      it "redirects to sign in page" do
        get :index
        expect(response).to redirect_to(login_url)
      end
    end

    context "when signed in" do
      before do
        sign_in user
        get :index
      end

      it "is successful" do
        expect(response).to be_success
      end

      it "assigns the correct user" do
        expect(assigns(:settings)).to eq user
      end
    end
  end

  describe "#update" do
    before do
      sign_in user
    end

    it "updates user settings" do
      attrs = { name: "New Name", email: "new@email.com" }
      put :update, settings: attrs
      expect(assigns(:settings).name).to eq attrs[:name]
      expect(assigns(:settings).email).to eq attrs[:email]
    end
  end

  describe "#update_api" do
    before do
      sign_in user
    end

    it "updates user's API" do
      original_api = user.api_key
      put :update_api
      expect(assigns(:settings).api_key).not_to eq original_api
    end
  end
end
