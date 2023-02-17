class RemoveExtraEmailCol < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :email_id
  end
end
