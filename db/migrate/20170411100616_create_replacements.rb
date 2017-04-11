class CreateReplacements < ActiveRecord::Migration
  def change
    create_table :replacements do |t|
      t.integer :user_id
      t.integer :caregiver_id
      t.integer :last_caregiver_id
      t.timestamps null: false
    end
  end
end
