class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!, :is_admin?, :load_all_leaf_categories
  load_and_authorize_resource
  layout "admin"

  def index
    @product = Product.new
    @search = Product.search params[:q]
    @products = @search.result.select(:id, :name, :price, :quantity, :description, :category_id)
      .includes(:category).order(created_at: :DESC).page(params[:page])
      .per Settings.admin.product_list.per_page
    respond_to do |format|
      format.html
      format.xls{render text: Product.all.to_csv}
    end
  end

  def new
    @categories = Category.select(:id, :name, :depth)
    @product = Product.new
    respond_to do |format|
      format.html{render partial: "product_form", local: {product: @product}}
    end
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t ".create_product_success"
    else
      flash[:notice] = t ".create_product_fail"
    end
    redirect_to :back
  end

  def update
    if @product.update_attributes product_params
      flash[:success] = t ".update_success"
    else
      flash[:danger] = t ".update_failed"
    end
    redirect_to :back
  end

  private
  def product_params
    params.required(:product).permit :name, :quantity, :category_id, :description,
      :price, :image, specifications_attributes: [:id, :feature_name,
      :feature_value, :_destroy]
  end

  def load_all_leaf_categories
    @categories_leaf = Category.all.reject{|category| !category.leaf?}
  end
end
