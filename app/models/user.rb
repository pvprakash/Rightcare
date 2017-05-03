class User < ActiveRecord::Base
  rolify


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # belongs_to :patient, :foreign_key => :patient_id,  :class_name => "User"
  # has_one :user, :foreign_key => :patient_id, :class_name => "User", :dependent  => :destroy
  has_one :patient, :dependent  => :destroy
  has_many :payments
  has_one :assign_caregiver ,:foreign_key => :caregiver_id, :class_name => "AssignCaregiver"
  has_many :feedbacks
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable
  before_destroy :remove_assign
  serialize :languages, Array
  
  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  # has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png",
  # storage: :dropbox,
  # dropbox_credentials: "#{Rails.root}/config/dropbox.yml"


  # scope :active, -> { joins(:roles).where('roles.name = ? AND active = ?','caregiver', false ) }
  scope :active, -> { where('active = ?', true) }
  # scope :caregiver_feedbacks, -> { Feedback.where(caregiver_id: self.id) }


  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validate :validate_state,:validate_city, :validate_pin_code, :validate_video_url
  # validates :pin_code, :numericality => true, :allow_nil => true
  ROLES = [["Patient", "patient"],["User", "user"]]
  CAREFOR = ["Mother","Father","Husband","Wife","Grandmother","Grandfather","Myself","Sister","Brother","Daughter","Son","Relative","Friend","Neighor","Other"]
  AMOUNT = [["ENTRY LEVEL CAREGIVERS - 600/day", 600],["EXPERIENCED CAREGIVERS - 900/day", 900],["SPECIALIZED CAREGIVERS - 1200/day", 1200],["QUALIFIED NURSES - 2400/day", 2400]]
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

  def remove_assign
    unless self.is_caregiver?
      if self.patient.assign_caregiver.present?
        caregiver_id = self.patient.assign_caregiver.caregiver_id
        User.find(caregiver_id).update_attributes(assign: false)
        self.patient.assign_caregiver.destroy
      end
    end
  end 

  def caregiver_feedbacks
    Feedback.where(caregiver_id: self.id)
  end

  def self.states
    states = CS.states(:in)
    states.map{|k,v| [v,k]}
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
      errors.add(:pin_code, "is invalid")
    end
  end

  def validate_video_url
    if self.video_url.present?
      begin 
        video = VideoInfo.new(self.video_url)
      rescue Exception
        errors.add(:video_url, "Invalid URL")
        # @message = "invalid url"
      end
    end
  end

  def validate_state
    unless self.state.present?
      errors.add(:state, "is invalid")
    end
  end


  def validate_city
    unless self.city.present?
      errors.add(:city, "is invalid")
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

  def full_name
    return self.first_name+" "+self.last_name
  end
end




