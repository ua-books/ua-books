class User < ApplicationRecord
  has_many :oauth_providers

  validates_presence_of :email
  validates_uniqueness_of :email

  def email=(value)
    super(value&.downcase)
  end
end
