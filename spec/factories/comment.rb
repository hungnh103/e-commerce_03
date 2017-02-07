require "faker"

FactoryGirl.define do
  factory :comment do
    content{Faker::Lorem.sentence}
    user_id{Faker::Number.number(1)}
    product_id{Faker::Number.number(1)}
  end
end
