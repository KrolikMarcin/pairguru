FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@gmail.pl" }
    sequence(:name) { |n| "Name#{n}" }
    password { "12345678" }
    confirmed_at { Time.current }
  end
end
