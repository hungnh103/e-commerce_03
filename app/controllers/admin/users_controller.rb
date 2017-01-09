class Admin::UsersController < ApplicationController
  def index
    @users = User.select(:name, :email, :role).order(created_at: :DESC)
      .page(params[:page]).per Settings.admin.users_list.per_page
  end
end
