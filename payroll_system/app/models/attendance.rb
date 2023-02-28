# frozen_string_literal: true

class Attendance < ApplicationRecord

  belongs_to :user

  before_validation :set_default_leaves

  validates :tot_work_days, comparison: { greater_than_or_equal_to: 0, message: 'Cannot have negative work days' }
  validates :user_id, presence: true
  validates :user_id, uniqueness: { scope: :current_month,
    message: 'There is existing record for the user in this month'}

  def set_default_leaves
    unpaid_leaves = 0 if unpaid_leaves.blank?
  end

end
