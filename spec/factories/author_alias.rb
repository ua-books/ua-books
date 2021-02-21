FactoryGirl.define do
  factory :author_alias do
    sequence(:first_name) { |i| "Оксана (#{i})" }
    last_name "Була"
  end
end
