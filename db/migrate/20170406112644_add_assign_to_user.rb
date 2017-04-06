class AddAssignToUser < ActiveRecord::Migration
  def change
    add_column :users, :assign, :boolean, :default => false
  end
end
