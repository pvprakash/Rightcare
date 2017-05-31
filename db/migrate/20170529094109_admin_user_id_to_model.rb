class AdminUserIdToModel < ActiveRecord::Migration
	def change
    add_column :users, :admin_user_id, :integer
    add_column :patients, :admin_user_id, :integer
    add_column :admin_users, :admin_user_id, :integer
  end
end
