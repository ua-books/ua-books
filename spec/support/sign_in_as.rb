module RSpec
  module FeatureHelper
    def sign_in_as(user)
      provider = user.oauth_providers.first!

      OmniAuth.config.mock_auth[provider.name.to_sym] = OmniAuth::AuthHash.new({
        :provider => provider.name,
        :uid => provider.uid,
      })

      visit "/auth/#{provider.name}/callback"
    ensure
      OmniAuth.config.mock_auth[provider.name.to_sym] = nil
    end
  end
end
