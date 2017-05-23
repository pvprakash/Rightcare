class Patient < ActiveRecord::Base
 belongs_to :user
 has_one :assign_caregiver
 
validates :first_name, presence: true
validate :validate_health_condition,:validate_service
serialize :health_conditions, Array
serialize :speciality_services, Array
serialize :languages, Array
serialize :extra_data, Hash
has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  

HEALTH_CONDITION = [["ALS","1"],
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

SERVICE = 
[["Ambulation","1"],
	["Hospice","2"],
	["Skin/Wound","3"],
	["Physical Therapy","4"],
	["Post Surgery Recovery","5"],
	["Prosthetics","6"],
	["Transportation","7"]]

LANGUAGE = 
[["Hindi","1"],
	["English","2"],
	["Bengali","3"],
  ["Telugu","4"],
  ["Marathi","5"],
  ["Tamil","6"],
  ["Urdu","7"],
  ["Kannada","8"],
  ["Gujarati","9"],
  ["OdiaMalayalam","10"],
  ["Sanskrit","11"]]


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


