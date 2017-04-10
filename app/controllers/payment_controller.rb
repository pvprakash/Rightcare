class PaymentController < ApplicationController
	 skip_before_action :verify_authenticity_token, except: [:show]

	def show
		@payment = Payment.find(params[:id])
		@caregiver = User.find(@payment.caregiver_id)
		@user = User.find(@payment.user_id)
	end 

	def purchase_status
		begin
		  @payment = Payment.process_razorpayment(payment_params)
		  redirect_to user_payment_path(current_user,@payment)
		rescue Exception
		  flash[:alert] = "Unable to process payment."
		  redirect_to root_path
		end
  end
  private
  def payment_params
    p = params.permit(:payment_id, :user_id, :caregiver_id, :price, :razorpay_payment_id)
    p.merge!({payment_id: p.delete(:razorpay_payment_id) || p[:payment_id]})
    p
  end

  def filter_params
    params.permit(:status, :page)
  end
end
