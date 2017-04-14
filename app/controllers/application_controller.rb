class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :availble_patient, except: :destroy 

  def availble_patient
  	if user_signed_in?
  		if current_user.patient.nil? && params[:controller] != "patients"
  			redirect_to new_user_patient_path(current_user)
  			return false
  	    end
    end
  end
end
