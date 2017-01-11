class Admin::UsersController < ApplicationController
  before_action :authenticate_user!, :is_admin?
  load_and_authorize_resource
  layout "admin"

  def index
    @users = User.select(:name, :email, :role).order(created_at: :DESC)
      .page(params[:page]).per Settings.admin.users_list.per_page
  end
end
