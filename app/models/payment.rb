class Payment < ActiveRecord::Base
	include PaymentConcerns::Razorpay
  serialize :extra_records, Hash
	belongs_to :user
	[:authorized, :captured, :refunded, :error].each do |scoped_key|
    scope scoped_key, -> { where('LOWER(status) = ?', scoped_key.to_s.downcase) }
  end

  def refund_at
    # refund_amount = params[:refund_amount]*100
    refund_amount = (self.price*15/100)*100
    payment_id = self.payment_id
    begin
    fetch_payment = Razorpay::Payment.fetch(payment_id)
    fetch_payment.refund({amount: refund_amount}) if refund_amount.present? 
    # fetch_payment.refund unless refund_amount.present?
    record = Payment.find_by_payment_id(payment_id)
    record.update_attributes(status: fetch_payment.status)
    return true
    rescue Exception
    return false
    end
  end

	 class << self
    def process_razorpayment(params)
      caregiver = User.find(params[:caregiver_id])
      razorpay_pmnt_obj = fetch_payment(params[:payment_id])
      status = fetch_payment(params[:payment_id]).status
      if status == "authorized"
        razorpay_pmnt_obj.capture({amount: (caregiver.amount.to_i*100)})
        razorpay_pmnt_obj = fetch_payment(params[:payment_id])
        params.merge!({status: razorpay_pmnt_obj.status, price: (razorpay_pmnt_obj.amount/100).to_f})
        caregiver.update_attributes(assign: true)
        rpo = razorpay_pmnt_obj
        extra_records = {entity: rpo.entity, currency: rpo.currency, refund_status:  rpo.refund_status, amount_refunded: rpo.amount_refunded, bank: rpo.bank, email: rpo.email, contact: rpo.contact,fee: rpo.fee, service_tax: rpo.service_tax ,created_at: rpo.created_at}
        p = Payment.new(params.merge(extra_records: extra_records))
        p.save     
      else
        raise StandardError, "UNable to capture payment"
      end
    end

    def process_refund(payment_id)
      fetch_payment(payment_id).refund
      record = Payment.find_by_payment_id(payment_id)
      record.update_attributes(status: fetch_payment(payment_id).status)
      return record
    end

    def filter(params)
      scope = params[:status] ? Payment.send(params[:status]) : Payment.authorized
      return scope
    end
  end
end
