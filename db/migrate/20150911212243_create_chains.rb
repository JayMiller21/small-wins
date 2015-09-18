class CreateChains < ActiveRecord::Migration
  def change
    create_table :chains do |t|

      t.timestamps
    end
  end
end
