class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.date :dob
      t.string :health_conditions
      t.string :speciality_services
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
