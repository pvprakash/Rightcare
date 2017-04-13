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
      UserMailer.payment_success(@payment.id).deliver_now
		  redirect_to user_payment_path(current_user,@payment)
		rescue Exception
		  flash[:alert] = "Unable to process payment."
		  redirect_to root_path
		end
    end

    def payment_receipt
      @payment = Payment.find(params[:id])
      kit = WickedPdf.new.pdf_from_string(render_to_string('payment/payment_receipt.html.erb', layout: 'pdf.html.erb'))
      send_data kit,
      filename: "Reciept #{Date.today.strftime('%Y%m%d')}.pdf",
      type: 'application/pdf'
      # respond_to do |format|
      #   format.pdf do
      #     render pdf: "file_name", template: 'payment/payment_receipt.html.erb' # Excluding ".pdf" extension.
      #   end
      # end
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
