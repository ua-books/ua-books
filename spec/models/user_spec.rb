require "rails_helper"

RSpec.describe User do
  specify "email normalization" do
    user = User.new(email: "HellO@ua-books.com")
    expect(user.email).to eq "hello@ua-books.com"
  end
end
