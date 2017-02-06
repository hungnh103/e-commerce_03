require "faker"

FactoryGirl.define do
  factory :product do
    name{Faker::Commerce.product_name}
    description{Faker::Lorem.sentence}
    quantity{Faker::Number.number(2)}
    price{Faker::Number.decimal(2,2)}
    image{Faker::Avatar.image("my-own-slug")}
    category_id 2
  end
end
