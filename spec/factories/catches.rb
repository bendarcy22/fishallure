FactoryGirl.define do
  factory :catch do
    association :user
    association :lure
    association :fish_type
    latitude 0
    longitude 0
    sequence(:caught_at) { |n| "201#{n}-06-06 012:00:00" }
  end
end
