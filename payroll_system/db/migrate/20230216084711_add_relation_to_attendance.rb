class AddRelationToAttendance < ActiveRecord::Migration[7.0]
  def change
    add_reference :attendances, :users, foreign_key: true
  end
end
