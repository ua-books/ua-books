module Dragonfly
  module DevS3DataStore
    private

    # https://github.com/markevans/dragonfly-s3_data_store/blob/15ba3f39a/lib/dragonfly/s3_data_store.rb#L126-L128
    def generate_uid(name)
      "dev/#{super}"
    end
  end
end

Dragonfly.app.configure do
  case Rails.env
  when "development"
    datastore :s3,
      region: "eu-central-1",
      bucket_name: "ua-books",
      storage_headers: {}, # remove `{'x-amz-acl' => 'public-read'}` defaults
      # these credentials are scoped to /dev folder only, so are safe to share in public
      access_key_id: "AKIA53OKKD65DGWLU4QJ",
      secret_access_key: "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"

    Dragonfly::S3DataStore.class_eval do
      prepend Dragonfly::DevS3DataStore
    end
  else
    datastore :s3,
      region: "eu-central-1",
      bucket_name: "ua-books",
      storage_headers: {}, # remove `{'x-amz-acl' => 'public-read'}` defaults
      access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
  end
end

Dragonfly.logger = Rails.logger

ActiveSupport.on_load(:active_record) do
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
