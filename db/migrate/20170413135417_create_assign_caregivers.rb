class CreateAssignCaregivers < ActiveRecord::Migration
  def change
    create_table :assign_caregivers do |t|
      t.integer :patient_id
      t.integer :caregiver_id
      t.boolean :assign, default: false
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps null: false
    end
  end
end
