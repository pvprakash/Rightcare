class UserMailer < ApplicationMailer
  # default :from => "notifications@example.com"
  def payment_success(payment_id)
    @payment = Payment.find(payment_id)
    @user = @payment.user
    @caregiver = User.find(@payment.caregiver_id)
    mail(:to => @user.email,:subject => "Payment successful")
  end

  def subscribes_email(blog_id, email, token)
    attachments.inline['logo.png'] =  File.read(Rails.root.join("app/assets/images/logo.png"))
  	@blog = Blog.find(blog_id)
    @token = token
    @email = email
  	#emails = Subscribe.all.map(&:email).join(',')
  	mail(:to => @email,:subject => "New blog created")
  end

  def request_for_caregiver(admin, caregiver, user)
    @caregiver = caregiver
    @user = user
    @admin = admin
    mail(to: @admin.email, subject: 'Request for caregiver purchase')
  end

  def signed_up(resourse_id)
    @user = User.find(resourse_id)
    mail(:to => "reach@rightcare.in",:subject => "New User created")
  end
end



  
