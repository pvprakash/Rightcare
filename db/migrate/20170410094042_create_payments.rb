class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :caregiver_id
      t.integer :user_id
      t.integer :price
      t.string :status
      t.string :payment_id
      t.timestamps null: false
    end
  end
end
