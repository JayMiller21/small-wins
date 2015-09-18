class CreateCompletedDays < ActiveRecord::Migration
  def change
    create_table :completed_days do |t|

      t.timestamps
    end
  end
end
