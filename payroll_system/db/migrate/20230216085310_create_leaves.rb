# frozen_string_literal: true

class CreateLeaves < ActiveRecord::Migration[7.0]
  def change
    create_table :leaves do |t|
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :leave_type, null: false
      t.text :leave_details
      t.integer :duration

      t.timestamps
    end
  end
end
