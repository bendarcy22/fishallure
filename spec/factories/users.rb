FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "testemail#{n}@hotmail.com" }
    sequence(:username) { |n| "testusername#{n}" }
    password "123456"
  end
end
