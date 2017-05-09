class AddExtraFieldToPatient < ActiveRecord::Migration
  def change
  	add_column :patients, :emergency_contact, :integer
  end
end
