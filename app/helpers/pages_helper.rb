module PagesHelper
  def get_now_links(amount_code)
  	html = ""
  	if !user_signed_in?
      html += link_to "get now", new_user_registration_path
  	elsif current_user.is_user?
  		html += "<a href='/users/list_caregiver?code=#{amount_code}'>get now</a>"
  	else
  		html += link_to "get now","#"
  	end
  	html.html_safe
  end


  def get_now_links_modal(amount_code)
    html = ""
    if !user_signed_in?
      html += link_to "continue", new_user_registration_path
    elsif current_user.is_user?
      html += "<a href='/users/list_caregiver?code=#{amount_code}'>continue</a>"
    else
      html += link_to "continue","#"
    end

    html1 = "<button class='myBtn'>get now</button>
      <div id='myModal1' class='modal'>
        <div class='modal-content'>
        <span class='close'>&times;</span>
        <p>"+html+"</p>
      </div>
    </div>"

    html1.html_safe
  end
end
