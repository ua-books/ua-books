class Uploadcare
  CONFIG = Rails.application.config_for(:uploadcare)

  class << self
    # https://uploadcare.com/docs/image_transformations/
    def url(cdn_url, operations)
      pipeline = operations.map { |fn, arg| "-/#{fn}/#{arg}/" }.join
      File.join(cdn_url, pipeline)
    end

    # https://uploadcare.com/docs/api_reference/upload/signed_uploads/
    def signature(valid_to)
      Digest::MD5.hexdigest "#{CONFIG.fetch("secret_key")}#{valid_to.to_i}"
    end
  end
end
