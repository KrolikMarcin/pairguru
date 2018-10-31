FactoryBot.define do
  factory :comment do
    body { "Text" }
    user
    movie

    trait :invalid do
      body { "" }
    end
  end
end
