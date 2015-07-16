require 'spec_helper'

describe User do

  let(:user) { create(:user) }
  let(:auth) { OmniAuth.config.add_mock(:twitter, { uid: '12345',
                                                    info: { name: 'test_user' }
                                                  }) }
  it "has a valid factory" do
    expect(user).to be_valid
  end

  context ".from_twitter" do
    it "create a new user from oauth" do
      expect { User.from_twitter(auth) }.to change(User, :count).by(1)
    end

    it "sets the users name" do
      expect(User.from_twitter(auth).name).to eq 'test_user'
    end
  end
end
