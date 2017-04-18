module UsersHelper
  def payment_link caregiver
    html = ""
    if @has_payment.nil? || @continue_caregiver
    html += link_to(image_tag("/assets/razorpay.png"), "#", id:"rzp-button1", :class=>"work ")
    elsif @has_payment.price.to_i.eql?(caregiver.amount.to_i)
    html +=  link_to "Replacement", replacement_user_path(caregiver.id), class: 'btn btn-primary'
    else
    html += '<span style="color: red; background: lightgoldenrodyellow;">You have already pay for caregiver </span>'
    end
    html.html_safe
  end
end
