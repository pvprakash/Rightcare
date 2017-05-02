class AddHitCountsBlogs < ActiveRecord::Migration
  def change
  	add_column :blogs, :hit_counts, :integer ,default: 0
  end
end
