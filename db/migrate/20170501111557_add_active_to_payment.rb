class AddActiveToPayment < ActiveRecord::Migration
  def change
  	add_column :payments, :active, :boolean ,default: true
  end
end
