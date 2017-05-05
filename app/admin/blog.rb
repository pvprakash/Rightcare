ActiveAdmin.register Blog do
  menu priority: 3
  permit_params :title, :relevant_to, :content, :blog_pic

  index do
    selectable_column
    id_column
    column :title
    column :relevant_to
    column :blog_pic do |pic|
      image_tag pic.blog_pic.url(:thumb)
    end
    column :content do |content|
      truncate(content.content, omision: "...", length: 30)
    end
    column :updated_at
    column :created_at
    actions
  end

  show do |ad|
    attributes_table do
      row :title
      row :relevant_to
      row :blog_pic do
        image_tag(ad.blog_pic.url(:thumb))
      end
      row :content do |content|
        raw content.content
      end
      row :created_at
    end
  end

  filter :title
  filter :relevant_to
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs "Create Blog" do
      f.input :title
      f.input :relevant_to
      f.input :blog_pic, hint: f.blog.blog_pic? ? image_tag(f.blog.blog_pic.url, height: '100') : content_tag(:span, "Upload JPG/PNG/GIF image")
      f.input :content, :as => :ckeditor
    end
    f.actions
  end

  before_create do |blog|
    blog.publisher_id = current_admin_user.id
  end

  after_create do |blog|
    @blog = blog
    @blog.delay(run_at: (1).minutes.from_now).subscribes_email
  end
end
