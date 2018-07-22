class User < ApplicationRecord
  has_many :oauth_providers
  belongs_to :publisher, optional: true

  validates_presence_of :email
  validates_uniqueness_of :email

  def email=(value)
    super(value&.downcase)
  end

  def publisher?
    publisher_id && !admin?
  end
end
