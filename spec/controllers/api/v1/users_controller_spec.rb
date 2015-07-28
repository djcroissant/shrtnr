require 'spec_helper'

describe Api::V1::UsersController, type: :controller do

  let(:link) { create(:link) }
  let(:user) { create(:user) }

  describe "#show" do
    context  "with invalid api_key" do
      it "returns a 401" do
        get :show, api_key: 'blank', url: 'abc123'
        expect(response.code).to eq '401'
      end
    end

    context "with a valid api_key" do
      let(:json) { JSON.parse(response.body) }

      before do
        link.update(user: user)
        get :show, api_key: user.api_key, email: user.email
      end

      it "returns a JSON response" do
        expect(response.content_type).to eq "application/json"
      end

      it "returns a name" do
        expect(json.keys).to include 'name'
        expect(json['name']).to include assigns(:user).name
      end
      it "returns an email" do
        expect(json.keys).to include 'email'
        expect(json['email']).to include assigns(:user).email
      end
      it "returns the user's links" do
        expect(json.keys).to include 'links'
        expect(json['links'].first.keys).to include 'short_url'
        expect(json['links'].first.keys).to include 'long_url'
        expect(json['links'].first.keys).to include 'clicks'
      end
    end

    context "with an invalid email" do
      let(:json) { JSON.parse(response.body) }

      before do
        get :show, api_key: user.api_key, email: 'nonexistent email'
      end

      it "returns a JSON body with an error message" do
        expect(response.body).to include "No user exists with that email!"
      end
    end
  end
end
