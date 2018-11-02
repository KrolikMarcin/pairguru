FactoryBot.define do
  factory :comment do
    body { "Text" }
    user
    movie

    trait :invalid do
      body { "" }
    end

    trait :outdated_week do
      created_at { Time.current - 30.days }
      updated_at { Time.current - 30.days }
    end
  end
end
