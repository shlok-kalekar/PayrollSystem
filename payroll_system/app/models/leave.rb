# frozen_string_literal: true

class Leave < ApplicationRecord

  belongs_to :user

  validates :end_date, comparison: { greater_than_or_equal_to: :start_date, message: 'Date should not be less than end date' }
  validates :leave_duration, comparison: { greater_than: 0, message: 'Leave cannot be negative or 0' }
  validates :user_id, presence: true

end
