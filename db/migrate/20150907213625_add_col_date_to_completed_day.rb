class AddColDateToCompletedDay < ActiveRecord::Migration
  def change
    change_table :completed_days do |t|
      t.date :date
    end
  end
end
