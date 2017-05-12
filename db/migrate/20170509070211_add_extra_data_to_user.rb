class AddExtraDataToUser < ActiveRecord::Migration
  def change
  	add_column :users, :extra_data, :string
  	add_column :users, :gender, :string
  end
end
