module PatientsHelper

	def patient_get_health patient
	 html=""
	 patient.health_conditions.each do |condition|
	 	
	 	html += Patient::HEALTH_CONDITION[condition.to_i-1][0]+","
	 end
	 return html.html_safe
	end

	def patient_get_speciality_services patient
	  html=""
	  patient.speciality_services.each do |condition|
	 	html += Patient::SERVICE[condition.to_i-1][0]+","
	  end
	  return html.html_safe
	end
end
