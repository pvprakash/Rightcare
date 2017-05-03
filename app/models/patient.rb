class Patient < ActiveRecord::Base
 belongs_to :user
 has_one :assign_caregiver
 
validates :first_name, presence: true
validate :validate_health_condition,:validate_service
serialize :health_conditions, Array
serialize :speciality_services, Array
serialize :languages, Array

HEALTH_CONDITION =  [["ALS","1"],
["Alzheimer's Disease","2"],
["Cancer","3"],
["Cardiovascular Disorders","4"],
["Dementia","5"],
["Diabetes","6"],
["Hypertension/High Blood Pressure","7"],
["HIV/AIDS","8"],
["Incontinence","9"],
["Multiple Sclerosis","10"],
["Neurological Disorders","11"],
["Orthopedic Care","12"],
["Paraplegia","13"],
["Parkinson's Disease","14"],
["Respiratory Disorders","15"],
["Seizers","16"],
["Stroke","17"],
["Other","18"]]

SERVICE = [
	["Ambulation","1"],
["Hospice","2"],
["Skin/Wound","3"],
["Physical Therapy","4"],
["Post Surgery Recovery","5"],
["Prosthetics","6"],
["Transportation","7"]]

LANGUAGE = 
[
["American Sign Language/ ASL","1"],
["Arabic","2"],
["Cantonese (Chinese)","3"],
["Mandrain (Chinese)","4"],
["Farsi","5"],
["Filipino(Tagalog)","6"],
["French","7"],
["German","8"],
["Hebrew","9"],
["Italian","10"],
["Japanese","11"],
["Korean","12"],
["Polish","13"],
["Portuguese","14"],
["Russian","15"],
["Spanish","16"],
["Swahili","17"],
["Tongan","18"],
["Vietnamese","19"],
["Other","20"]]


def validate_health_condition
	unless self.health_conditions.present? 
		errors.add(:health_conditions, "Invalid Health Conditions")
	end
end

def validate_service
	unless self.health_conditions.present? 
		errors.add(:speciality_services, "Invalid Service")
	end
end

def full_name
  return self.first_name+" "+self.last_name
end
end


