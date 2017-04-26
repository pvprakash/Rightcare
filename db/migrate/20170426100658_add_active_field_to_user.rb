class AddActiveFieldToUser < ActiveRecord::Migration
  def change
     add_column :users, :active, :boolean ,default: false
     add_column :users, :skills, :string
  end
end
