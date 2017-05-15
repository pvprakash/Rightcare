class AddFieldToSubscribe < ActiveRecord::Migration
  def change
    add_column :subscribes, :token, :text
  end
end
