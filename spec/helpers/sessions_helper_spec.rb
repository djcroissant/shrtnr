require 'spec_helper'

describe SessionsHelper do

  let(:user) { create(:user) }

  describe "#current_user" do
    it "stores a user if signed_in?" do
      session[:user_id] = user.id
      expect(current_user).to eq user
    end

    it "returns nil if not signed_in?" do
      expect(current_user).to be_nil
    end
  end

  describe "signed_in?" do
    it "returns true if signed in" do
      session[:user_id] = user.id
      expect(signed_in?).to be_truthy
    end

    it "returns false if not signed in" do
      expect(signed_in?).to be_falsey
    end
  end

  describe "#signed_in_through_twitter?" do
    it "returns true if signed in through twitter" do
      session[:user_id] = user.id
      expect(signed_in_through_twitter?).to be_truthy
    end

    let(:reg_user) { create(:user, uid: nil) }

    it "returns true if signed in through twitter" do
      session[:user_id] = reg_user.id
      expect(signed_in_through_twitter?).to be_falsey
    end
  end

  describe "can_tweet?" do
    it "returns true if user can tweet" do
      session[:user_id] = user.id
      expect(can_tweet?).to be_truthy
    end

    let(:reg_user) { create(:user, twitter_token: nil) }

    it "returns true if signed in through twitter" do
      session[:user_id] = reg_user.id
      expect(can_tweet?).to be_falsey
    end
  end
end
