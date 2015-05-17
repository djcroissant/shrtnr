require 'securerandom'

class User < ActiveRecord::Base
  has_secure_password
  before_create :generate_api_key

  has_many :links

  validates_uniqueness_of :email
  validates_uniqueness_of :api_key

  def self.from_twitter(auth)
    create! do |user|
      user.name = auth.info.nickname
      user.uid = auth.uid
      user.twitter_token = auth.credentials.token
      user.twitter_secret = auth.credentials.secret
      user.password = SecureRandom.hex
    end
  end

  def tweet(tweet)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = TWITTER[:TWITTER_CLIENT_ID]
      config.consumer_secret     = TWITTER[:TWITTER_CLIENT_SECRET]
      config.access_token        = twitter_token
      config.access_token_secret = twitter_secret
    end
    client.update(tweet)
  end

  def generate_api_key
    self.api_key = SecureRandom.hex(16)
  end
end
