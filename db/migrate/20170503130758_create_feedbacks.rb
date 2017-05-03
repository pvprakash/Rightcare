class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :caregiver_id
      t.integer :user_id
      t.string :content
      t.timestamps null: false
    end
  end
end
