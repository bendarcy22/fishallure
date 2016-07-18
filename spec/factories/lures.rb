FactoryGirl.define do
  factory :lure do
    sequence(:name) { |n| "Slug-Go #{n}" }
    sequence(:manufacturer) { |n| "Lunker City #{n}" }
    association :category
    association :user
  end
end
