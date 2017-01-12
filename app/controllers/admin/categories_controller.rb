class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!, :is_admin?
  load_and_authorize_resource
  layout "admin"

  def index
    @category = Category.new
    @search = Category.ransack params[:q]
    @categories = @search.result.includes(:products).order :left
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

  def update
    if @category.update_attributes category_params
      flash[:success] = t ".update_success"
    else
      flash[:danger] = t".update_fail"
    end
    redirect_to :back
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
    params.permit :name, :description
  end
end
