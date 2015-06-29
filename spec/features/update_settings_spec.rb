require 'spec_helper'

describe "changing user info" do

  context "with name only" do
    before do
      sign_up_with "test@test.com", "password", "password"
      visit settings_path
      fill_in "Name", with: "First Last"
      click_button "Update"
    end

    it "tells you that update was successful" do
      expect(page).to have_content "Successfully updated settings"
    end

    it "stays on settings page" do
      expect(current_path).to eq "/settings"
    end
  end

  context "with valid email" do
    before do
      sign_up_with "test@test.com", "password", "password"
      visit settings_path
      fill_in "Email", with: "test@test.com"
      click_button "Update"
    end

    it "tells you that update was successful" do
      expect(page).to have_content "Successfully updated settings"
    end

    it "stays on settings page" do
      expect(current_path).to eq "/settings"
    end
  end

  context "with invalid email" do
    before do
      sign_up_with "test@test.com", "password", "password"
      visit settings_path
      fill_in "Email", with: "bad_email"
      click_button "Update"
    end

    it "tells you that update was unsuccessful" do
      expect(page).to have_content "Failed to update settings"
    end

    it "stays on settings page" do
      expect(current_path).to eq "/settings"
    end

    it "repopulates email field with original value" do
      expect(find_field('Email').value).to eq "test@test.com"
    end
  end

end
