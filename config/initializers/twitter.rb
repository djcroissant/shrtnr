OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, TWITTER[:TWITTER_CLIENT_ID], TWITTER[:TWITTER_CLIENT_SECRET]
end
