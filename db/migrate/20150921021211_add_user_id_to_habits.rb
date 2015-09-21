class AddUserIdToHabits < ActiveRecord::Migration
  def change
    add_reference :habits, :user, foreign_key: true
  end
end
