require "common"
class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!, :is_admin?
  include SharedMethods
  layout "admin"

  def show
    @orders = []
    revenue_order
    respond_to do |format|
      format.html
      format.json {
        render json: [
          {type: I18n.t("line"), name: I18n.t("total_pay"),
            data: @orders,
            tooltip: {valueSuffix: I18n.t("order")}}
        ]
      }
    end
  end

  private
  def revenue_order
    current_date = get_current_monday - Settings.one.day
    Settings.weekday.times.each do |day|
      @orders << Order.sum_order(current_date
        .strftime(Settings.date_format)).sum(:total_money)
      current_date = current_date - Settings.one.day
    end
    @orders.reverse!
  end
end
