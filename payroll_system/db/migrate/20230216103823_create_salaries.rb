# frozen_string_literal: true

class CreateSalaries < ActiveRecord::Migration[7.0]
  def change
    create_table :salaries do |t|
      t.decimal :total_salary
      t.date :salary_date

      t.timestamps
    end
  end
end
