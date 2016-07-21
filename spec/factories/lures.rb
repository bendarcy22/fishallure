FactoryGirl.define do
  factory :lure do
    sequence(:name) { |n| "Slug-Go #{n}" }
    sequence(:manufacturer) { |n| "Lunker City #{n}" }
    sequence(:category) { |n| "Jig #{n}" }
    association :user
  end
end
