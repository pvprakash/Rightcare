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
end
