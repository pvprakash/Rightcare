class UserMailer < ApplicationMailer
  # default :from => "notifications@example.com"
  def payment_success(payment_id)
    @payment = Payment.find(payment_id)
    @user = @payment.user
    @caregiver = User.find(@payment.caregiver_id)
    mail(:to => @user.email,:subject => "Payment successful")
  end
end
