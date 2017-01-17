class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details

  before_create :set_status_order
  validates :shipping_address, presence: true

  enum status: [:progress, :shipping, :delivered, :rejected]

  def calc_total_pay product_carts
    each_amount = []
    if product_carts
      product_carts.each do |product, quantity|
        each_amount << ApplicationController.helpers
          .calc_price_of_order_detail(product, quantity)
      end
    end
    total_pay = each_amount.reduce(0){|total_pay, price| total_pay += price}
  end

  def update_order! session_cart, address, _phone
    product_carts = session_cart.map do |id, quantity|
      [Product.find_by(id: id), quantity] end
    update_attributes total_money: calc_total_pay(product_carts),
      shipping_address: address
    if save
      session_cart.keys.each do |item|
        quantity = session_cart[item].to_i
        order_detail = order_details.build
        product_in_order = Product.find_by id: item.to_i
        rest_quantity = product_in_order.quantity - quantity
        product_in_order.update_attributes quantity: rest_quantity
        price = ApplicationController.helpers
          .calc_price_of_order_detail product_in_order, quantity
        order_detail.update quantity: quantity,
          product_id: item.to_i,
          price: price
        order_detail.save
      end
      session_cart.clear
    end
  end

  scope :order_count, -> date_time do
    where("date(created_at) = '#{date_time}'")
  end

  scope :sum_order, -> date_time do
    where("date(created_at) = '#{date_time}'")
  end

  private
  def set_status_order
    self[:status] = :progress
  end
end
