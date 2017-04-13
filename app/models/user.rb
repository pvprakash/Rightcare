class User < ActiveRecord::Base
  rolify


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # belongs_to :patient, :foreign_key => :patient_id,  :class_name => "User"
  # has_one :user, :foreign_key => :patient_id, :class_name => "User", :dependent  => :destroy
  has_one :patient
  has_many :payments
  has_one :assign_caregiver ,:foreign_key => :caregiver_id, :class_name => "AssignCaregiver", :dependent  => :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  # validates :pin_code, :numericality => true, :allow_nil => true
  ROLES = [["Patient", "patient"],["User", "user"]]
  CAREFOR = ["Mother","Father","Husband","Wife","Grandmother","Grandfather","Myself","Sister","Brother","Daughter","Son","Relative","Friend","Neighor","Other"]
  AMOUNT = [["ENTRY LEVEL CAREGIVERS - 600/day", 600],["EXPERIENCED CAREGIVERS - 900/day", 900],["SPECIALIZED CAREGIVERS - 1200/day", 1200],["QUALIFIED NURSES - 2400/day", 2400]]
  def is_patient?
  	self.roles.first.name.eql?("patient")
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




