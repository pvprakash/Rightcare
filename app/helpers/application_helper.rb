module ApplicationHelper
  def link_account
  	html = ""
  	unless user_signed_in?
  	  html += link_to "My Account",new_user_session_path,class: "phone-box  clear-box text-center"
    else
    	# html += "<div class='btn-group show-on-hover'> <button type='button' class='btn btn-default dropdown-toggle' data-toggle='dropdown'> Action <span class='caret'></span> </button> <ul class='dropdown-menu' role='menu'> <li><a href='#'>Action</a></li></ul> </div>"
    	html += "<div class='btn-group show-on-hover'>"
    	html += "<button class='phone-box  clear-box text-center m-phonebox dropdown-toggle ' type='button' data-toggle='dropdown'>Hi #{current_user.first_name} <span class='fa fa-angle-down'><span></button>"
      # html += "<button type='button' class='btn btn-default dropdown-toggle' data-toggle='dropdown'> Action <span class='caret'></span> </button>"
  		html += "<ul class='dropdown-menu' role='menu'> <li>#{link_to 'Logout',destroy_user_session_path, method: :delete }</li>"
  		html += "<li>#{link_to 'Payment Details', payment_details_users_path }</li>" if user_signed_in?
      html += "</ul>"
      html += "</div>"
     end
    return html.html_safe
  end
end
