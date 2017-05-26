class Career < ActiveRecord::Base
  validates_length_of :mobile, :numericality => true, :allow_nil => false,:is => 10	
end
