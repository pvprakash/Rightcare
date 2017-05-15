class Subscribe < ActiveRecord::Base
	validates_uniqueness_of :email
	belongs_to :blog
  before_create :generate_token


  protected
  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Subscribe.exists?(token: random_token)
    end
  end
end
