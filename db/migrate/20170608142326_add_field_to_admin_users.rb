class AddFieldToAdminUsers < ActiveRecord::Migration
  def change
  	add_column :admin_users, :name, :string
    add_column :admin_users, :mobile, :integer, limit: 8
    add_column :admin_users, :address, :text
  end
end
