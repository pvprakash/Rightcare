class AddMobileNumberAndCareForToUser < ActiveRecord::Migration
  def change
  	add_column :users, :mobile_number, :integer
    add_column :users, :care_for, :string
  end
end
