module UsersHelper
  def payment_link caregiver
    
    html = ""
    if (@is_assign.nil? || @continue_caregiver) && !caregiver.assign

    html += link_to(image_tag("/assets/razorpay.png"), "#", id:"rzp-button1", :class=>"work ")
    elsif @has_payment.price.to_i.eql?(caregiver.amount.to_i*15) && (!current_user.patient.assign_caregiver.caregiver_id.eql?(caregiver.id) && !caregiver.assign_caregiver.present?)
    html +=  link_to "Replacement", replacement_user_path(caregiver.id), class: 'btn btn-primary'
    elsif caregiver.assign && (!current_user.patient.assign_caregiver.caregiver_id.eql?(caregiver.id) rescue false)
    html += link_to "Request For", request_caregiver_user_path(caregiver.id), class: 'btn btn-primary'
    # html += '<span style="color: red; background: lightgoldenrodyellow;">Request for caregiver </span>'
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

  def static_rating_star(rating)
    html = ""
    (1..5).each do |num|
      html += "<i class='#{rating.to_i >= num ? "fa fa-star" : "fa fa-star-o" }' aria-hidden='true'></i>"
    end 
    html += rating.to_s  
    return html.html_safe
  end
end
