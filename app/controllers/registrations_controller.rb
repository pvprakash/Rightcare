class RegistrationsController < Devise::RegistrationsController
  
  def create
    build_resource(sign_up_params)
    if resource.save
      resource.add_role 'user'
      UserMailer.signed_up(resource.id).deliver_now
    end
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
    
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
    # add custom create logic here
  end



  private
  
  def after_sign_up_path_for(resource)
    "/users/#{resource.id}/patients/new"
  end
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role, :patient_id,:care_for, :pin_code, :state, :city,:avatar)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password,:care_for,:role, :patient_id, :pin_code, :state, :city,:avatar)
  end
end