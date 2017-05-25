ActiveAdmin.register Patient do
	menu priority: 3
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

permit_params :first_name, :last_name,:gender,:dob,:health_conditions => [], :speciality_services => [],:languages => []


	index do
		selectable_column
		column :first_name
		column :last_name
		column :gender
		column :dob
		column :health_conditions do |p|
			content_tag(:p, p.health_conditions.collect{|k| Patient::HEALTH_CONDITION[k.to_i-1][0]}.join(","))
		end
		column :speciality_services do |p|
			content_tag(:p, p.speciality_services.collect{|k| Patient::SERVICE[k.to_i-1][0]}.join(","))
		end
		column :languages do |p|
			content_tag(:p, p.languages.collect{|k| Patient::LANGUAGE[k.to_i-1][0]}.join(","))
		end
		actions
	end
	form  do |f|   
	 f.inputs "Patient" do           
	  render partial: 'form'  
	 end                       
	end


	show do
    attributes_table do
      row :first_name
			row :last_name
			row :gender
			row :dob
			row :health_conditions do |p|
				content_tag(:p, p.health_conditions.collect{|k| Patient::HEALTH_CONDITION[k.to_i-1][0]}.join(","))
			end
			row :speciality_services do |p|
				content_tag(:p, p.speciality_services.collect{|k| Patient::SERVICE[k.to_i-1][0]}.join(","))
			end
			row :languages do |p|
				content_tag(:p, p.languages.collect{|k| Patient::LANGUAGE[k.to_i-1][0]}.join(","))
			end
		  end
    active_admin_comments
  end 

	controller do
    def create
    begin
	  user_id = params[:patient][:user_id]
	  user = User.find(user_id)
	  patient = user.build_patient(patient_params)
    patient.save
    redirect_to admin_patient_path(patient)
    rescue Exception
       flash[:error] = "something went wrong"
      redirect_to admin_patients_path
    end
    end

    def edit
    	@patient = Patient.find(params[:id])
    end

	  private

	  def patient_params
	     params.require(:patient).permit(:first_name, :last_name,:gender,:dob, :health_conditions => [], :speciality_services => [],:languages => [])
	  end
  end
end

