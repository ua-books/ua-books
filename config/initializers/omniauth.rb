Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development?
    provider :developer, :fields => [:email]
  end

  # Use http://lvh.me:3000/auth/google for local testing.
  provider :google_oauth2,
    ENV.fetch("GOOGLE_OAUTH_CLIENT_ID", "1021687790193-s5umo3tct7cukfnq0jp1jcf2jtuoibp0.apps.googleusercontent.com"),
    ENV.fetch("GOOGLE_OAUTH_CLIENT_SECRET", "PNTaDMeZz7Lr_u666R7imKxi"),
    name: "google"
end

OmniAuth.config.logger = Rails.logger
OmniAuth.config.test_mode = Rails.env.test?
