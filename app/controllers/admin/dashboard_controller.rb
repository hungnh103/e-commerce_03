class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!, :is_admin?
  layout "admin"

  def show
  end
end
