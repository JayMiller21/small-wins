class AddCurrentToChains < ActiveRecord::Migration
  def change
    add_column :chains, :current, :boolean
  end
end
