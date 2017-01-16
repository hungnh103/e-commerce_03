class OrdersController < ApplicationController
  before_action :authenticate_user!, :load_user
  before_action :load_cart, :load_order

  def new
    @product_carts = @session_cart.map do |id, quantity|
      [Product.find_by(id: id), quantity] end
    @total_pay = @order.calc_total_pay @product_carts
  end

  def create
    if @order.update_order! @session_cart,
      params[:address], params[:phone]
      flash[:success] = t ".orders_create_successfully"
      OrderMailer.delay.confirm_order @order, current_user
    else
      flash[:danger] = @order.errors.full_messages
    end
    redirect_to root_url
  end

  private
  def load_user
    @user = current_user
    render_404 unless @user
  end

  def load_order
    @order = @user.orders.build
    render_404 unless @user
  end

  def load_cart
    @session_cart = session[:cart]
    redirect_to root_url if @session_cart.blank?
  end
end
