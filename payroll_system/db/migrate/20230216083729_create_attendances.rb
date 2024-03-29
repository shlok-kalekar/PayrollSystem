# frozen_string_literal: true

class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.date :attendance_month
      t.integer :tot_work_days
      t.integer :unpaid_leaves
      t.float :attend_rate

      t.timestamps
    end
  end
end
