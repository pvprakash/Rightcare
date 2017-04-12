class AddAddressPinCodeToUser < ActiveRecord::Migration
  def change
  	add_column :users, :address, :string
    add_column :users, :pin_code, :integer
  end
end
