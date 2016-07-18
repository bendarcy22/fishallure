FactoryGirl.define do
  factory :fish_type do
    association :user
    sequence(:name) { |n| "Fish #{n}" }
  end
end
