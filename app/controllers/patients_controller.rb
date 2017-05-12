class PatientsController < ApplicationController
  before_action :authenticate_user!
   def new
   	@patient = Patient.new 
   end

   def create
   	user = User.find params[:user_id]
    @patient = user.build_patient(patient_params)
    if @patient.save
      redirect_to root_path
    else
      render :new
    end
   end
   
   protected
   def patient_params
     extra_params = (params[:patient] || {})[:extra_data].keys
     params.require(:patient).permit(:first_name, :last_name,:gender,:dob,:avatar,:emergency_contact, :health_conditions => [], :speciality_services => [],:languages => [],extra_data: extra_params)
   end
end
