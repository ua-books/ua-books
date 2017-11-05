FactoryGirl.define do
  factory :work do
    title true
    association :type, factory: :text_author_type
  end
end
