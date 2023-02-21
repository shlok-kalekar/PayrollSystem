# frozen_string_literal: true

class CreateTaxDeductions < ActiveRecord::Migration[7.0]
  def change
    create_table :tax_deductions do |t|
      t.string :deduct_type
      t.decimal :amount_deduct
      t.date :financial_year

      t.timestamps
    end
  end
end
