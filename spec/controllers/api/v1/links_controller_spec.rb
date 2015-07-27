require 'spec_helper'

describe Api::V1::LinksController, type: :controller do

  let(:link) { create(:link) }
  let(:user) { create(:user) }

  describe "#create" do
    context  "with invalid api_key" do
      it "returns a 401" do
        get :create, api_key: 'blank', url: 'http://test.com'
        expect(response.code).to eq '401'
      end
    end

    context "with a valid api_key" do
      let(:json) { JSON.parse(response.body) }

      before do
        get :create, api_key: user.api_key, url: 'http://test.com'
      end

      it "returns a JSON response" do
        expect(response.content_type).to eq "application/json"
      end

      it "returns a short url" do
        expect(json.keys).to include 'shorturl'
        expect(json['shorturl']).to include assigns(:link).short_url
      end
    end

    context "with an invalid url parameter" do
      let(:json) { JSON.parse(response.body) }

      before do
        get :create, api_key: user.api_key, url: 'illformed url'
      end

      it "returns a JSON body with an error message" do
        expect(response.body).to include '{"errors":{"long_url":["is invalid"]}}'
      end
    end
  end

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
        get :show, api_key: user.api_key, url: link.short_url
      end

      it "returns a JSON response" do
        expect(response.content_type).to eq "application/json"
      end

      it "returns a short url" do
        expect(json.keys).to include 'short_url'
        expect(json['short_url']).to include assigns(:link).short_url
      end
      it "returns a long url" do
        expect(json.keys).to include 'long_url'
        expect(json['long_url']).to include assigns(:link).long_url
      end
      it "returns number of clicks" do
        expect(json.keys).to include 'clicks'
        expect(json['clicks']).to eq assigns(:link).clicks
      end
      it "returns a user" do
        expect(json.keys).to include 'user'
        expect(json['user']['name']).to eq assigns(:link).user.name
        expect(json['user']['email']).to eq assigns(:link).user.email
      end
    end

    context "with an invalid url parameter" do
      let(:json) { JSON.parse(response.body) }

      before do
        get :show, api_key: user.api_key, url: 'nonexistent url'
      end

      it "returns a JSON body with an error message" do
        expect(response.body).to include "That short_url doesn't exist!"
      end
    end
  end
end
