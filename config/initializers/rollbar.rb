require 'rollbar/rails'

Rollbar.configure do |config|
  # Without configuration, Rollbar is enabled in all environments.
  # Enable Rollbar only in production.
  config.enabled = Rails.env.production?

  # Access token
  config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']
end
