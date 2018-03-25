# See https://github.com/omniauth/omniauth/wiki/Auth-Hash-Schema
class OmniauthRequest < Struct.new(:omniauth_hash)
  def self.user(omniauth_hash)
    new(omniauth_hash).user
  end

  def user
    find_user || create_user
  end

  def provider
    omniauth_hash.fetch("provider")
  end

  def uid
    omniauth_hash.fetch("uid")
  end

  def info
    omniauth_hash.fetch("info")
  end

  def email
    info["email"]
  end

  def first_name
    info["first_name"]
  end

  def last_name
    info["last_name"]
  end

  private

  def find_user
    User.joins(:oauth_providers).find_by(oauth_providers: {name: provider, uid: uid})
  end

  def create_user
    if email.present?
      user = User.new(email: email, email_verified: true)
    else
      user = User.new(email: "#{provider}-#{uid}@ua-books.test", email_verified: false)
    end

    user.first_name = first_name.presence || "-"
    user.last_name = last_name.presence || "-"
    user.oauth_providers.build(name: provider, uid: uid)
    user.save!
    user
  end
end
