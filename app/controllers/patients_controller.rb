class PatientsController < ApplicationController
   def new
   	@patient = Patient.new 
   end

   def create
   	user = User.find params[:user_id]
    patient = user.build_patient(patient_params)
    patient.save
    redirect_to root_path
   end
   
   protected
   def patient_params
     params.require(:patient).permit(:first_name, :last_name,:gender,:dob, :health_conditions => [], :speciality_services => [])
   end
end
