Dragonfly.app.configure do
  datastore :s3,
    region: "eu-central-1",
    bucket_name: "ua-books",
    storage_headers: {}, # remove `{'x-amz-acl' => 'public-read'}` defaults
    access_key_id: ENV["AWS_ACCESS_KEY_ID"],
    secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
end

Dragonfly.logger = Rails.logger

ActiveSupport.on_load(:active_record) do
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
