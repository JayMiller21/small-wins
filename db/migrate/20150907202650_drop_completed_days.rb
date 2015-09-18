class DropCompletedDays < ActiveRecord::Migration
  def change
    drop_table :completed_days
  end
end
