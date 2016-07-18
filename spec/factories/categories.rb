FactoryGirl.define do
  factory :category do
    sequence(:type) { |n| "Category #{n}" }
  end
end
