Rails.application.config.middleware.use OmniAuth::Builder do
  provider :fitbit, ENV['fitbit_client_id'], ENV['fitbit_client_secret'], scope: "activity profile"
end