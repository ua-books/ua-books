FactoryGirl.define do
  factory :person do
    first_name "Оксана"
    last_name "Була"
    gender "female"

    trait :with_alias do
      after(:build) do |person|
        person.aliases.build(first_name: person.first_name, last_name: person.last_name)
      end
    end
  end
end
