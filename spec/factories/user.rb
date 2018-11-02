FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@gmail.pl" }
    sequence(:name) { |n| "Name#{n}" }
    password { "12345678" }
    confirmed_at { Time.current }

    trait :with_many_comments do
      transient do
        sequence(:comments_count) { |n| n }
      end

      after(:create) do |user, evaluator|
        create_list(:comment, evaluator.comments_count, user: user)
      end
    end
  end
end
