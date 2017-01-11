class ProductsController < ApplicationController
  load_and_authorize_resource

  def show
    if session[:recent].length >= Settings.max_item_for_recent
      session[:recent].deleted_at 0
    end
    session[:recent].push @product.id unless session[:recent].include? @product.id
  end
end
