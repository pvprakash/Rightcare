class User < ActiveRecord::Base
  rolify


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # belongs_to :patient, :foreign_key => :patient_id,  :class_name => "User"
  # has_one :user, :foreign_key => :patient_id, :class_name => "User", :dependent  => :destroy
  has_one :patient, :dependent  => :destroy
  has_many :payments
  has_one :assign_caregiver ,:foreign_key => :caregiver_id, :class_name => "AssignCaregiver"
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable
  before_destroy :remove_assign
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png",
  storage: :dropbox,
  dropbox_credentials: "#{Rails.root}/config/dropbox.yml"



  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validate :validate_care_for, :validate_pin_code, :on => :create

  # validates :pin_code, :numericality => true, :allow_nil => true
  ROLES = [["Patient", "patient"],["User", "user"]]
  CAREFOR = ["Mother","Father","Husband","Wife","Grandmother","Grandfather","Myself","Sister","Brother","Daughter","Son","Relative","Friend","Neighor","Other"]
  AMOUNT = [["ENTRY LEVEL CAREGIVERS - 600/day", 600],["EXPERIENCED CAREGIVERS - 900/day", 900],["SPECIALIZED CAREGIVERS - 1200/day", 1200],["QUALIFIED NURSES - 2400/day", 2400]]
  

  def remove_assign
  unless self.is_caregiver?
    if self.patient.assign_caregiver.present?
      caregiver_id = self.patient.assign_caregiver.caregiver_id
      User.find(caregiver_id).update_attributes(assign: false)
      self.patient.assign_caregiver.destroy
    end
  end

  end 

  def is_patient?
  	self.roles.first.name.eql?("patient")
  end
  

  def validate_care_for
    unless self.care_for.present?
      errors.add(:care_for, "Who is this care can't be empty")
    end
  end

  def validate_pin_code
    unless self.pin_code.to_s.length > 5
      errors.add(:pin_code, "Pin Code is invalid")
    end
  end

  def is_caregiver?
    self.roles.first.name.eql?("caregiver")
  end

  def is_user?
  	self.roles.first.name.eql?("user")
  end

  def role?
  	self.roles.first.name
  end
end




