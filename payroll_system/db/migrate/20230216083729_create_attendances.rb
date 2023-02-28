# frozen_string_literal: true

class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.date :current_month
      t.integer :tot_work_days
      t.integer :unpaid_leaves
      t.decimal :attend_rate

      t.timestamps
    end
  end
end
