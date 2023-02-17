class AddRelationToLeave < ActiveRecord::Migration[7.0]
  def change
    add_reference :leaves, :users, foreign_key: true
  end
end
