class CartController < ApplicationController
  def index
    @cart = session[:cart] ? session[:cart] : {}
    @product_carts = @cart.map {|id, quantity| [Product.find_by(id: id), quantity]}
  end
end
