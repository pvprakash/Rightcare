ActiveAdmin.register_page "Caregivers" do
  action_item :caregivers do
    link_to "New Caregiver", "/admin/caregivers/new"
  end


  controller do

    define_method(:form) do
     	@user = User.new
    end
    

		def caregivers
		 @users = User.joins(:roles).where("roles.name = 'caregiver'") if current_admin_user.super_user?
		  @users = User.joins(:roles).where("roles.name = 'caregiver' AND admin_user_id = #{current_admin_user.id}") unless current_admin_user.super_user?
		end

		def create
		  user =  current_admin_user.users.new(first_name: params[:first_name],last_name: params[:last_name],email: params[:email],password: params[:password],password_confirmation: params[:password_confirmation], pin_code: params[:pin_code],state: params[:state],city: params[:city],active: true,avatar: params[:avatar])
		  user.amount = params[:amount]
		  user.skills = params[:skills]
		  user.video_url = params[:url]
		  user.languages = params[:languages]
		  user.gender = params[:gender]
		  user.extra_data = {id_prof: params[:id_prof],emergency_contact: params[:emergency_contact],experience: params[:experience],profile: params[:profile]}
		  if user.save
		    user.add_role 'caregiver'
		    flash[:notice] = 'successfully saved'
		    redirect_to admin_caregivers_path
		  else
		    str = ""
		    user.errors.messages.each do |key, value|
		      str  << key.to_s+" "+value.join()+", "
		    end
		    flash[:notice] =  str
		    redirect_to '/admin/caregivers/new'
		  end
		end

		def edit_caregiver
      @user = User.find(params[:id])
    end

    def update
	    user = User.find(params[:id])
	    user_hash = {first_name: params[:first_name],last_name: params[:last_name],email: params[:email], pin_code: params[:pin_code],state: params[:state],city: params[:city],active: true, admin_user_id: current_admin_user.id}
	    user_hash.merge!(password: params[:password],password_confirmation: params[:password_confirmation]) if params[:password].present? && params[:password_confirmation].present?
	    user_hash.merge!(avatar: params[:avatar]) if params[:avatar].present? 
	    user_hash = user_hash.merge(amount:params[:amount],skills:params[:skills],video_url: params[:url],languages: params[:languages] ,gender: params[:gender],extra_data: {id_prof: params[:id_prof],emergency_contact: params[:emergency_contact],experience: params[:experience],profile: params[:profile]})
	    if user.update_attributes(user_hash)
	      flash[:notice] =  'successfully updated'
	    	redirect_to admin_caregivers_path
	   	else
	     	str = ""
	      user.errors.messages.each do |key, value|
	        str  << key.to_s+" "+value.join()+", "
	      end
	      flash[:error] =  str
	      redirect_to "/admin/caregivers/#{user.id}/edit"
	    end
    end
    def destroy
    	@user = User.find(params[:id])
    	@user.destroy
    	redirect_to admin_caregivers_path
    end
  end
 end