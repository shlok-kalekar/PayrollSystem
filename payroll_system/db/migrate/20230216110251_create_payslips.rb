# frozen_string_literal: true

class CreatePayslips < ActiveRecord::Migration[7.0]
  def change
    create_table :payslips do |t|
      t.decimal :attendance_deductible
      t.decimal :taxable_salary
      t.decimal :tot_tax
      t.decimal :payable_salary
      t.date :slip_month

      t.timestamps
    end
  end
end
