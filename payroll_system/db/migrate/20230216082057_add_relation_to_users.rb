class AddRelationToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :roles, :users, foreign_key: true
  end
end
