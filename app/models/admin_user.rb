class AdminUser < ActiveRecord::Base
  role_based_authorizable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
  has_many :blogs, foreign_key: :publisher_id
  has_many :users
  has_many :patients
  has_many :admin_users, :class_name => 'AdminUser', :foreign_key => 'admin_user_id'
  belongs_to :admin_user, :class_name => 'AdminUser'
end
