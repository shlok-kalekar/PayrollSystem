class AddRelationToSalary < ActiveRecord::Migration[7.0]
  def change
    add_reference :salaries, :users, foreign_key: true
  end
end
