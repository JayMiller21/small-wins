class FixHabitIdInChains < ActiveRecord::Migration
  def change
    remove_reference :chains, :habits, foreign_key: true
    add_reference :chains, :habit, foreign_key: true
  end
end
