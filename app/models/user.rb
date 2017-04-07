class User < ActiveRecord::Base
  rolify


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to :patient, :foreign_key => :patient_id,  :class_name => "User"
  has_one :user, :foreign_key => :patient_id, :class_name => "User", :dependent  => :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  ROLES = [["Patient", "patient"],["User", "user"]]
  CAREFOR = ["Mother","Father","Husband","Wife","Grandmother","Grandfather","Myself","Sister","Brother","Daughter","Son","Relative","Friend","Neighor","Other"]

  def is_patient?
  	self.roles.first.name.eql?("patient")
  end

  def is_user?
  	self.roles.first.name.eql?("user")
  end

  def role?
  	self.roles.first.name
  end
end




