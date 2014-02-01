Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, Figaro.env.twitter_consumer_key, Figaro.env.twitter_consumer_secret
end
