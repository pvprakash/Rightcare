class CreateCareers < ActiveRecord::Migration
  def change
    create_table :careers do |t|
    	t.string :name
    	t.integer :mobile,limit: 8
		t.timestamps null: false
    end
  end
end
