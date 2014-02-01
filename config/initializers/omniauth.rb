twitter_key = ENV["TWITTER_CONSUMER_KEY"]
twitter_secret = ENV["TWITTER_CONSUMER_SECRET"]
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, twitter_key, twitter_secret
end
