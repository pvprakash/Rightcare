class PaymentController < ApplicationController
   skip_before_action :verify_authenticity_token, except: [:show]

  def show
    @payment = Payment.find(params[:id])
    @caregiver = User.find(@payment.caregiver_id)
    @user = User.find(@payment.user_id)
  end

  def purchase_status
    begin
      last_payment = current_user.payments.active.order(:created_at)
      last_payment_date = last_payment.try(:created_at)
      caregiver_releasing_date = last_payment.try(:delayed_job).try(:run_at)
      continue_with_same_caregiver = (last_payment_date && caregiver_releasing_date && (((caregiver_releasing_date - last_payment_date) / 3600).round <= 24) && (((caregiver_releasing_date - last_payment_date) / 3600) > 0) && current_user.patient.try(:assign_caregiver).try(:caregiver_id) == params[:caregiver_id].to_i && ((remain_time = (caregiver_releasing_date - last_payment_date) / 3600)).round)

      @payment = Payment.process_razorpayment(payment_params)
      UserMailer.payment_success(@payment.id).deliver_now
      if continue_with_same_caregiver && remain_time
        last_payment.try(:delayed_job).delete
        delayed_job = @payment.delay(run_at: (360 + remain_time.to_i).hours.from_now).caregiver_relase
      else
        delayed_job = @payment.delay(run_at: 360.hours.from_now).caregiver_relase
      end
      @payment.update(delayed_job_id: delayed_job.id)
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
