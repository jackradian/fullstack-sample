FactoryBot.define do
  factory :movie do
    association :user
    url { "https://www.youtube.com/watch?v=jNQXAC9IVRw" }
  end
end
