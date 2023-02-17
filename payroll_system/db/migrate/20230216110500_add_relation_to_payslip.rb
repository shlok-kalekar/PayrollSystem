class AddRelationToPayslip < ActiveRecord::Migration[7.0]
  def change
    add_reference :payslips, :users, foreign_key: true
  end
end
