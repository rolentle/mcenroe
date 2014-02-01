if Rails.env.production?
  twitter_key = ENV["TWITTER_CONSUMER_KEY"]
  twitter_secret = ENV["TWITTER_CONSUMER_SECRET"]
else
  twitter_key = Figaro.env.twitter_consumer_key
  twitter_secret = Figaro.env.twitter_consumer_secret
end
Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, twitter_key, twitter_secret
end
