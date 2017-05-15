class Blog < ActiveRecord::Base
	belongs_to :admin_user, foreign_key: :publisher_id
	has_many :subscribes
	has_attached_file :blog_pic, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	# storage: :dropbox,
 #  dropbox_credentials: "#{Rails.root}/config/dropbox.yml"
  validates_attachment_content_type :blog_pic, content_type: /\Aimage\/.*\z/

  def self.subscribes_email(blog)
  	blog = Blog.find(blog.id)
  	subscribes = Subscribe.all.collect{|k| {email: k.email, token: k.token}}
  	subscribes.each do |subs|
  	  UserMailer.subscribes_email(blog.id, subs[:email], subs[:token]).deliver_now
  	end
  end

end


