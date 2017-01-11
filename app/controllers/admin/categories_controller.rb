class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!, :is_admin?
  load_and_authorize_resource
  layout "admin"

  def index
    @category = Category.new
    @categories = Category.includes(:products).order :left
  end

  def create
    @category = Category.new category_params
    respond_to do |format|
      if @category.update_category params[:parent_id]
        format.html{render @category}
      else
        format.html
      end
    end
  end

  def destroy
    respond_to do |format|
      if !@category.leaf? || @category.products.any?
        format.js{render status: 500}
      elsif @category.delete_category && @category.destroy
        format.html
      end
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end
end
