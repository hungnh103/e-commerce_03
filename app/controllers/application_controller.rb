class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :load_recent_view_session, :load_view_object

  def after_sign_in_path_for resource
    if resource.admin?
      admin_root_path
    else
      session[:previous_url] || root_path
    end
  end

  private
  def is_admin?
    authenticate_user!
    return if current_user.admin?
    flash[:alert] = t "wrong_authorize"
    redirect_to root_path
  end

  def load_recent_view_session
    session[:recent] = [] if session[:recent].nil?
  end

  def load_view_object
    @support = Supports::StaticPageSupport.new
    @recent_viewed_products = session[:recent].map{|id| Product.find_by id: id} if session[:recent]
  end
end
