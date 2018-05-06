FactoryBot.define do
  factory :person do
    firstname "John"
    lastname "Doe"
    sequence(:email, 100) { |n| "user#{n}@admin.com" }
    identifier "0100000009"
  end
end
