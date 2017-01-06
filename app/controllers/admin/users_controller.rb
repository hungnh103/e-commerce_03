class Admin::UsersController < ApplicationController
  def index
    @users = User.select(:name, :email, :role).order(created_at: :DESC)
      .paginate page: params[:page], per_page: Settings.admin.users_list.per_page
  end
end
