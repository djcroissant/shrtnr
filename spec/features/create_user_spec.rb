require 'spec_helper'

describe "creating a user" do
  context "with invalid email" do
    before do
      sign_up_with "bad_email", "password", "password"
    end

    it "tells the user they entered an invalid email" do
      expect(page).to have_content "Invalid Email"
    end

    it "stays on signup page" do
      expect(current_path).to eq "/users"
    end

    it "repopulates email field with original value" do
      expect(find_field('Email').value).to eq "bad_email"
    end
  end

  context "with valid params" do

    before do
      sign_up_with "test@test.com", "password", "password"
    end

    it "tells the user they have signed up" do
      expect(page).to have_content "You have signed up"
    end

    it "sends them to the dashboard" do
      expect(current_path).to eq "/dashboard"
    end
  end

  context "with invalid params" do

    before do
      sign_up_with "test@test.com", "password", "invalid_password_confirmation"
    end

    it "tells the user they made a mistake" do
      expect(page).to have_content "Password confirmation doesn't match Password"
    end

    it "repopulates email field with original value" do
      expect(find_field('Email').value).to eq "test@test.com"
    end
  end
end
