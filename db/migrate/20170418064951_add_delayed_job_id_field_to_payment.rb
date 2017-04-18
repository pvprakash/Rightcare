class AddDelayedJobIdFieldToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :delayed_job_id, :integer
  end
end
