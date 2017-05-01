module UsersHelper
  def payment_link caregiver
    
    html = ""
    if @is_assign.nil? || @continue_caregiver

    html += link_to(image_tag("/assets/razorpay.png"), "#", id:"rzp-button1", :class=>"work ")
    elsif @has_payment.price.to_i.eql?(caregiver.amount.to_i*15)
    html +=  link_to "Replacement", replacement_user_path(caregiver.id), class: 'btn btn-primary'
    else
    html += '<span style="color: red; background: lightgoldenrodyellow;">You have already pay for caregiver </span>'
    end
    html.html_safe
  end


  def caregiver_experience caregiver
    case caregiver.amount
    when 600
    "ENTRY LEVEL"
    when 900
    "EXPERIENCED"
    when 1200
    "SPECIALIZED CAREGIVERS"
    when 2400
    "QUALIFIED NURSE"
    end
  end
end
