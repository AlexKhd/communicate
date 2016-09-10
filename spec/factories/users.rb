FactoryGirl.define do
  factory :user do
    name 'John Doe Sr'
    sequence(:email) { |n| "person#{n}@example.com" }
    password 'tester'
    password_confirmation 'tester'
    confirmed_at Date.today
  end

  trait :is_admin do
    name 'Administrator'
    role 'admin'
  end

  trait :is_anonymous do
    name 'anonymous'
  end
end
