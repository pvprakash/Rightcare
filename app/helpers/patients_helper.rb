module PatientsHelper

	def patient_get_health patient
	 html=""
	 patient.health_conditions.each do |condition|
	 	
	 	html += "<li>"+Patient::HEALTH_CONDITION[condition.to_i-1][0]+"</li>"
	 end
	 return html.html_safe
	end

	def patient_get_speciality_services patient
	  html=""
	  patient.speciality_services.each.with_index(1) do |condition,index|
	 	html += Patient::SERVICE[condition.to_i-1][0]
	 	html += index.eql?(patient.speciality_services.length) ? "" : "," 
	  end
	  return html.html_safe
	end
end
