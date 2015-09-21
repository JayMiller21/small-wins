class RemoveExampleFieldsFromUsersTable < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :provider, :uid, :image, :token, :expires_at
    end
  end
end
