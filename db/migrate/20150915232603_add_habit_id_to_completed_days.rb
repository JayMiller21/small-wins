class AddHabitIdToCompletedDays < ActiveRecord::Migration
  def change
    add_reference :completed_days, :habits, foreign_key: true
  end
end
