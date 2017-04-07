module PagesHelper
  def get_now_links
  	html = ""
  	if !user_signed_in?
  		html += link_to "get now", new_user_registration_path
  	elsif current_user.is_user?
  		html += link_to "get now",list_caregiver_users_path
  	else
  		html += link_to "get now","#"
  	end
  	html.html_safe
  end
end
