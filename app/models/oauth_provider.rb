# Allows multiple providers (Google, FB etc) and multiple
# accounts (within a provider) to be linked to a single User.
class OauthProvider < ApplicationRecord
  belongs_to :user

  providers = %w[google]
  providers << "developer" unless Rails.env.production?
  enum name: providers.zip(providers).to_h

  validates_presence_of :name, :uid
  validates_uniqueness_of :uid, scope: :name
end
