module UsersHelper
  def payment_link
    html = ""
    unless @has_payment.present?
    html += link_to( image_tag("/assets/razorpay.png"), "#", id:"rzp-button1", :class=>"work ")
    else
    html += '<span style="color: red; background: lightgoldenrodyellow;">you have already pay for caregiver </span>'
    # html +=  ""
    end
    html.html_safe
  end
end
