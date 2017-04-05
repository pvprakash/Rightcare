class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = [["Patient", "patient"],["User", "user"]]


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
