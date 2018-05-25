Recaptcha.configure do |config|
  config.site_key = ENV['RECAPTCHA_ASKMORE_SITE_KEY']
  config.secret_key = ENV['RECAPTCHA_ASKMORE_SECRET_KEY']
end
