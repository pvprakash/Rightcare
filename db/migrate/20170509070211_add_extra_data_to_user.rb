class AddExtraDataToUser < ActiveRecord::Migration
  def change
  	add_column :users, :extra_data, :string
  end
end
