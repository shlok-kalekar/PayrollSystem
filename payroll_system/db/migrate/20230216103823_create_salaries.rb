# frozen_string_literal: true

class CreateSalaries < ActiveRecord::Migration[7.0]
  def change
    create_table :salaries do |t|
      t.float :monthly_salary
      t.date :salary_month

      t.timestamps
    end
  end
end
