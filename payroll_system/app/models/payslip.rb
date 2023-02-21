# frozen_string_literal: true

class Payslip < ApplicationRecord

  belongs_to :user

  validates :attendance_deductible, comparison: { greater_than_or_equal_to: 0, message: 'Cannot have negative deductible' }
  validates :taxable_salary, comparison: { greater_than_or_equal_to: 0, message: 'Cannot have negative salary' }
  validates :tot_tax, comparison: { greater_than_or_equal_to: 0, message: 'Cannot have negative salary' }
  validates :payable_salary, comparison: { greater_than_or_equal_to: 0, message: 'Cannot have negative salary' }
  validates :user_id, presence: true

end
