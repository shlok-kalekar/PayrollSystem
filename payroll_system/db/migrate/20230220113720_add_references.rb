class AddReferences < ActiveRecord::Migration[7.0]
  def change
    add_reference :attendances, :user, foreign_key: true
    add_reference :leaves, :user, foreign_key: true
    add_reference :salaries, :user, foreign_key: true
    add_reference :tax_deductions, :user, foreign_key: true
    add_reference :payslips, :user, foreign_key: true
    add_reference :users, :role, foreign_key: true, :default=>2
    change_column_default :attendances, :unpaid_leaves, 0
  end
end
