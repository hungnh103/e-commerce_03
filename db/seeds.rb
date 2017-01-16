User.create! name: "admin", email: "admin@demo.com", role: :admin,
  password: "123qwe", password_confirmation: "123qwe"
User.create! name: "bibi", email: "hungnh103@gmail.com", role: :user,
  password: "123qwe", password_confirmation: "123qwe"

20.times do |n|
  name = Faker::Name.name
  email = "bibi#{n+1}@demo.com"
  password = "123qwe"
  User.create! name: name, email: email, role: :user, password: password,
    password_confirmation: password
end

Category.create! name: :electronics, description: "mo ta electronics", depth: 0, left: 1, right: 6
Category.create! name: :phone, description: "mo ta phone", depth: 1, left: 2, right: 3
Category.create! name: :tablet, description: "mo ta tablet", depth: 1, left: 4, right: 5

Category.create! name: :books, description: "mo ta books", depth: 0, left: 6, right: 11
Category.create! name: :comic, description: "mo ta comic", depth: 1, left: 7, right: 8
Category.create! name: :novel, description: "mo ta novel", depth: 1, left: 9, right: 10

10.times do |n|
  name = Faker::Name.name
  Product.create! name: name, price: 15000000, description: "mo ta #{name}",
    quantity: 99, category_id: 2
  name = Faker::Name.name
  Product.create! name: name, price: 15000000, description: "mo ta #{name}",
    quantity: 99, category_id: 3
  name = Faker::Name.name
  Product.create! name: name, price: 15000000, description: "mo ta #{name}",
    quantity: 99, category_id: 5
  name = Faker::Name.name
  Product.create! name: name, price: 15000000, description: "mo ta #{name}",
    quantity: 99, category_id: 6
end

10.times do
  fullname = Faker::Name::name_with_middle
  telephone = Faker::PhoneNumber.cell_phone
  address = Faker::Address.street_address
  user_id = rand 21 + 1
  AddressBook.create! fullname: fullname, telephone: telephone,
    address: address, user_id: user_id
end
