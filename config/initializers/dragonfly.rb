require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret Rails.env.production? ? ENV.fetch("DRAGONFLY_SECRET") : "391e94e6ddcd1a9225f1755f4645f9daebd18d830d444413bc52f5f7b92ab0ba"

  url_format "/media/:job/:name"

  # WORKAROUND
  #
  # Dragonfly's `default` was designed to auto-whitelist assets to be fetched:
  # https://github.com/markevans/dragonfly/blob/b8af810e647fc21e43ccc42b69beb6c9baa40abe/lib/dragonfly/model/attachment_class_methods.rb#L32-L34
  # https://github.com/markevans/dragonfly/blob/b8af810e647fc21e43ccc42b69beb6c9baa40abe/lib/dragonfly/model/attachment_class_methods.rb#L67-L70
  #
  # However, during a check:
  # https://github.com/markevans/dragonfly/blob/b8bd236f7af3f192df702cd93cb7f4fa9ec58906/lib/dragonfly/server.rb#L130-L134
  # `step.path` contains absolute path, that makes the check to fail.
  fetch_file_whitelist [
    Rails.root.join("public/system/dragonfly/no_image.png").to_s,
  ]

  datastore :file,
    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
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
