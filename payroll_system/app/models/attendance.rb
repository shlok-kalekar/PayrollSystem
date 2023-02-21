# frozen_string_literal: true

class Attendance < ApplicationRecord

  belongs_to :user

  validates :tot_work_days, comparison: { greater_than_or_equal_to: 0, message: 'Cannot have negative work days' }
  validates :user_id, presence: true

end
