# frozen_string_literal: true

class CreateTaxDeductions < ActiveRecord::Migration[7.0]
  def change
    create_table :tax_deductions do |t|
      t.string :deduct_type
      t.float :deduct_amount
      t.date :financial_year

      t.timestamps
    end
  end
end
