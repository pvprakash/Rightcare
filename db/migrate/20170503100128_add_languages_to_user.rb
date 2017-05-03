class AddLanguagesToUser < ActiveRecord::Migration
  def change
    add_column :users, :languages, :string
  end
end
