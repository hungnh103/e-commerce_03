User.create! name: "admin", email: "admin@demo.com", role: :admin,
  password: "123qwe", password_confirmation: "123qwe"

20.times do |n|
  name = Faker::Name.name
  email = "bibi#{n+1}@demo.com"
  password = "123qwe"
  User.create! name: name, email: email, role: :user, password: password,
    password_confirmation: password
end

Category.create! name: :electronics, description: Faker::Lorem.sentence,
  depth: 0, left: 1, right: 6
Category.create! name: :phone, description: Faker::Lorem.sentence,
  depth: 1, left: 2, right: 3
Category.create! name: :tablet, description: Faker::Lorem.sentence,
  depth: 1, left: 4, right: 5

Category.create! name: :books, description: Faker::Lorem.sentence,
  depth: 0, left: 6, right: 11
Category.create! name: :comic, description: Faker::Lorem.sentence,
  depth: 1, left: 7, right: 8
Category.create! name: :novel, description: Faker::Lorem.sentence,
  depth: 1, left: 9, right: 10

30.times do |n|
  name = "phone " + Faker::App.name
  price = 1000 + (rand 10000)
  quantity = 4567 + (rand 10000)
  Product.create! name: name, price: price, description: Faker::Lorem.paragraph,
    quantity: quantity, category_id: 2
  name = "tablet " + Faker::App.name
  price = 1000 + (rand 1000)
  quantity = 4567 + (rand 10000)
  Product.create! name: name, price: price, description: Faker::Lorem.paragraph,
    quantity: quantity, category_id: 3

  name = "comic " + Faker::Book.title
  price = 1000 + (rand 1000)
  quantity = 4567 + (rand 10000)
  Product.create! name: name, price: price, description: Faker::Lorem.paragraph,
    quantity: quantity, category_id: 5
  name = "novel " + Faker::Book.title
  price = 1000 + (rand 1000)
  quantity = 4567 + (rand 10000)
  Product.create! name: name, price: price, description: Faker::Lorem.paragraph,
    quantity: quantity, category_id: 6
end

10.times do
  fullname = Faker::Name::name_with_middle
  telephone = Faker::PhoneNumber.cell_phone
  address = Faker::Address.street_address
  user_id = rand 21 + 1
  AddressBook.create! fullname: fullname, telephone: telephone,
    address: address, user_id: user_id
end

users = User.take 6
15.times do |n|
  content = Faker::Lorem.sentence
  status = "pending"
  flag = rand 3
  if flag == 1; status = "accepted" end
  if flag == 2; status = "rejected" end
  users.each do |user|
    user.requests.create! content: content, status: status,
      created_at: Time.now - (rand 30).day - (rand 10 + 1).hour - (rand 35).minute
  end
end

products = Product.take 3
32.times do |n|
  total_money = 0
  products.each do |product|
    price = product.price
    quantity = 1 + rand(5)
    total_money += price * quantity
    product_id = product.id
    order_id = n + 1
    OrderDetail.create! price: price, quantity: quantity,
      product_id: product_id, order_id: order_id
  end
  user_id = 2
  shipping_address = Faker::Address.street_address
  status = "progress"
  o = Order.create! user_id: user_id, shipping_address: shipping_address,
    status: status, total_money: total_money
  flag = rand 4
  if flag == 1; status = "shipping" end
  if flag == 2; status = "delivered" end
  if flag == 3; status = "rejected" end
  o.status = status
  o.save!
end
