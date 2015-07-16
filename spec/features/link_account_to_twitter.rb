require 'spec_helper'

describe 'linking account to twitter' do
  context "Either no Twitter account for uid exists OR
           Twitter account already linked to current session id" do
    it "replaces current name with Twitter name"
    it "sets uid to match Twitter account"
    it "sets provider to :twitter"

  end

  context 'Twitter account for uid already exists, but with different user_id' do
    it "replaces current name with Twitter name"
    it "sets uid to match Twitter account"
    it "sets provider to :twitter"
    it "adds links from Twitter account to current account"
    it "deletes instance of User that was associated with Twitter uid but under
        a different user_id"
  end
end
