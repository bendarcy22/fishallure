FactoryGirl.define do
  factory :catch do
    association :user
    association :lure
    association :fish_type
    latitude 0
    longitude 0
    sequence(:caught_at) { |n| "2016-01-01" }
  end
end
