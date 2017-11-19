require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "391e94e6ddcd1a9225f1755f4645f9daebd18d830d444413bc52f5f7b92ab0ba"

  url_format "/media/:job/:name"

  datastore :file,
    root_path: Rails.root.join('public/dragonfly', Rails.env),
    server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
