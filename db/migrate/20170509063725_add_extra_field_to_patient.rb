class AddExtraFieldToPatient < ActiveRecord::Migration
  def change
  	add_column :patients, :emergency_contact, :integer, limit: 8
  	add_column :patients, :extra_data, :string
  end
end
