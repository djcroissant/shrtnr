require 'spec_helper'

describe "creating a short url" do
  context "when not signed in and long url is blank" do
    before do
      visit home_path
      click_button "Shorten It!"
    end

    it "stays on home page" do
      expect(current_path).to eq "/home"
    end

    it "displays a warning" do
      expect(page).to have_content "Your URL was not valid"
    end
  end

  context "when signed in and long url is not blank" do
    before do
      sign_up_with "test@test.com", "password", "password"
      visit dashboard_path
      fill_in "long_url", with: "http://www.hello.com"
      click_button "Shorten It!"
    end

    it "displays a notice that URL was successfully added" do
      expect(page).to have_content "URL added"
    end

    it "displays a warning if link already exists" do
      visit dashboard_path
      fill_in "long_url", with: "http://www.hello.com"
      click_button "Shorten It!"
      expect(page).to have_content "This link already exists"
    end
  end
end
