class Admin::ExcelController < ApplicationController
  before_action :authenticate_user!, :is_admin?

  def create
    Product.import params[:file]
    redirect_to :back, notice: t(".product_import")
  end
end
