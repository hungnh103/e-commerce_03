class OrderMailer < ApplicationMailer
  def confirm_order order, user
    @order = order
    mail to: user.email, subject: t("confirm_order")
  end
end
