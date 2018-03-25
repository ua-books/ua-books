FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@ua-books.test" }
    first_name "-"
    last_name "-"
    sequence(:oauth_providers) { |uid| [OauthProvider.new(name: "google", uid: uid)] }

    factory :admin
  end
end
