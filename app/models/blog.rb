class Blog < ActiveRecord::Base
	belongs_to :admin_user, foreign_key: :publisher_id
	has_attached_file :blog_pic, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	# storage: :dropbox,
 #  dropbox_credentials: "#{Rails.root}/config/dropbox.yml"
  validates_attachment_content_type :blog_pic, content_type: /\Aimage\/.*\z/
end
