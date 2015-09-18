class FixHabitIdInCompletedDays < ActiveRecord::Migration
  def change
    remove_reference :completed_days, :habits, foreign_key: true
    add_reference :completed_days, :habit, foreign_key: true
  end
end
