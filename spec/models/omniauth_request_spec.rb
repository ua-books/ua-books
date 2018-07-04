require "rails_helper"

RSpec.describe OmniauthRequest do
  describe ".user" do
    it "finds existing user" do
      user = create(:user, oauth_providers: [OauthProvider.new(name: "google", uid: "1234")])
      expect(OmniauthRequest.user("provider" => "google", "uid" => "1234")).to eq user
    end

    it "creates user when full info is provided" do
      user = OmniauthRequest.user(
        "provider" => "google",
        "uid" => "1234",
        "info" => {
          "email" => "rich@hickey.com",
          "first_name" => "Rich",
          "last_name" => "Hickey",
        }
      )

      expect(user.oauth_providers.first!).to have_attributes(
        name: "google",
        uid: "1234",
      )

      expect(user).to have_attributes(
        email: "rich@hickey.com",
        email_verified: true,
        first_name: "Rich",
        last_name: "Hickey",
      )
    end
  end
end
