require 'spec_helper'

describe SettingsController, type: :controller do

  let(:user) { create(:user) }
  let(:attributes) { attributes_for :user }

  before do
    allow(self.controller).to receive(:current_user).and_return(user)
  end

  describe "GET #index" do
    it "assigns current_user to @settings" do
      get :index
      expect(assigns(:settings)).to eq(user)
    end

    it "is successful" do
      get :index
      expect(response).to be_success
    end

    it "renders the index view" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "POST #update" do
    context "with valid attributes" do
      it "updates attributes of @settings" do
        post :update, :settings => {name: "New Name", email: "new@email.com"}
        expect(user[:name]).to eq("New Name")
        expect(user[:email]).to eq("new@email.com")
      end

      it "redirects to the settings page" do
        post :update, :settings => {name: "New Name", email: "new@email.com"}
        expect(response).to redirect_to(settings_url)
      end
    end

    context "with invalid attributes" do
      it "does not update attributes of @settings" do
        name_test = user[:name]
        email_test = user[:email]
        post :update, :settings => {name: "New Name", email: "bad_email"}
        expect(user[:name]).to eq(name_test)
        expect(user[:email]).to eq(email_test)
      end

      it "redirects to the setting page" do
        post :update, :settings => {name: "New Name", email: "bad_email"}
        expect(response).to redirect_to(settings_url)
      end
    end
  end


end
