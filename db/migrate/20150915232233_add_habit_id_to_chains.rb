class AddHabitIdToChains < ActiveRecord::Migration
  def change
    add_reference :chains, :habits, foreign_key: true
  end
end
