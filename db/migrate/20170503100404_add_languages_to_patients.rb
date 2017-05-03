class AddLanguagesToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :languages, :string
  end
end
