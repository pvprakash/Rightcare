class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :relevant_to
      t.text :content
      t.integer :publisher_id
      t.attachment :blog_pic

      t.timestamps null: false
    end
  end
end
