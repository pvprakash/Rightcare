module ApplicationHelper
  def link_account
    html = ""
    unless user_signed_in?
      html+= "<a data-toggle='modal' href='#login5' class ='phone-box login-sec' >My Account</a>"
       # html += link_to "My Account","#tallModal5",class: "phone-box  clear-box text-center"
    else
      # html += "<div class='btn-group show-on-hover'> <button type='button' class='btn btn-default dropdown-toggle' data-toggle='dropdown'> Action <span class='caret'></span> </button> <ul class='dropdown-menu' role='menu'> <li><a href='#'>Action</a></li></ul> </div>"
      html += "<div class='btn-group show-on-hover'>"
      html += "<button class='phone-box  clear-box text-center m-phonebox dropdown-toggle ' type='button' data-toggle='dropdown'>Hi #{current_user.first_name} <span class='fa fa-angle-down'><span></button>"
      # html += "<button type='button' class='btn btn-default dropdown-toggle' data-toggle='dropdown'> Action <span class='caret'></span> </button>"
      html += "<ul class='dropdown-menu' role='menu'> <li>#{link_to 'Logout',destroy_user_session_path, method: :delete }</li>"
      html += "<li>#{link_to 'Caregiver Details', caregiver_details_users_path }</li>" if user_signed_in?
      html += "<li>#{link_to 'Payment Details', payment_details_users_path }</li>" if user_signed_in?
       html += "<li>#{link_to 'Patient Details', patient_details_user_path(current_user) }</li>" if user_signed_in?
      html += "</ul>"
      html += "</div>"
     end
    return html.html_safe
  end


   def model_error_messages(resource)
    return "" unless model_error_messages?(resource)

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    "<div id='error_explanation'>
      <h2>#{sentence}</h2>
      <ul>#{messages}</ul>
    </div>".html_safe
  end

  def model_error_messages?(resource)
    !resource.errors.empty?
  end

end
