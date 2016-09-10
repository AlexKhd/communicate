FactoryGirl.define do
  factory :chatroom do
    name Faker::Lorem.characters(15)
  end
end
