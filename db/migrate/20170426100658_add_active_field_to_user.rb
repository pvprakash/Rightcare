class AddActiveFieldToUser < ActiveRecord::Migration
  def change
     add_column :users, :active, :boolean ,default: false
     add_column :users, :skills, :string
     add_column :users, :video_url, :string
  end
end
