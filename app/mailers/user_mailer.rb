class UserMailer < ApplicationMailer
  # default :from => "notifications@example.com"
  def payment_success(payment_id)
    @payment = Payment.find(payment_id)
    @user = @payment.user
    @caregiver = User.find(@payment.caregiver_id)
    mail(:to => @user.email,:subject => "Payment successful")
  end

  def subscribes_email(blog_id)
  	@blog = Blog.find(blog_id)
  	emails = Subscribe.all.map(&:email).join(',')
  	mail(:to => emails,:subject => "New blog created")
  end
end
