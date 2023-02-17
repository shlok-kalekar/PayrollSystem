class CreatePayslips < ActiveRecord::Migration[7.0]
  def change
    create_table :payslips do |t|
      t.float :attendance_deductible
      t.float :taxable_salary
      t.float :tot_tax
      t.float :payable_salary
      t.date :slip_month

      t.timestamps
    end
  end
end
