# frozen_string_literal: true

class Payslip < ApplicationRecord
  belongs_to :user

  validates :attendance_cut, :remaining_salary, :tot_tax, :payable_salary,
            comparison: { greater_than_or_equal_to: 0, message: 'Cannot have negative value' }
  validates :user_id, presence: true
end
