class AddStartDateAndEndDateToChains < ActiveRecord::Migration
  def change
    add_column :chains, :start_date, :date
    add_column :chains, :end_date, :date
  end
end
