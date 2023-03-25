FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "Test User #{n}" }
    password { "password" }
  end
end
