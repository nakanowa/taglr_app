OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :tumblr, Settings.tumblr.consumer_key, Settings.tumblr.consumer_secret
end