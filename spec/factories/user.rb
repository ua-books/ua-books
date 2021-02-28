FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@ua-books.test" }
    first_name "-"
    last_name "-"
    oauth_providers { [OauthProvider.new(name: "google", uid: email)] }

    factory :admin do
      admin true
    end

    factory :publisher_user do
      publisher
    end

    trait :dev_auth do
      oauth_providers { [OauthProvider.new(name: "developer", uid: email)] }
    end
  end
end
