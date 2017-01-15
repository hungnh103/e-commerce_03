class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!, :is_admin?
  load_and_authorize_resource
  layout "admin"

  def index
    @orders = Order.order(created_at: :desc)
      .page(params[:page]).per Settings.admin.orders_list.per_page
  end

  def update
    return if params[:status].nil?
    if @order.update_attributes status: params[:status].to_i
      flash[:success] = t ".update_success"
    else
      flash[:notice] = t ".update_fail"
    end
    redirect_to admin_orders_path
  end
end
