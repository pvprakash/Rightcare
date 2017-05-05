class Subscribe < ActiveRecord::Base
	validates_uniqueness_of :email
	belongs_to :blog
end
