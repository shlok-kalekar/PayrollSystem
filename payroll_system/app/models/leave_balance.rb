# frozen_string_literal: true

class LeaveBalance < ApplicationRecord

  belongs_to :user
  
  before_validation :set_default_status
  before_validation :set_leave_duration

  validates :end_date, comparison: { greater_than_or_equal_to: :start_date, message: 'Date should not be less than end date' }
  validates :start_date, :end_date, :overlap => {:scope => "user_id", message: "Existing Leave on same dates"}
  validates :leave_duration, comparison: { greater_than: 0, message: 'Leave duration is 0. Please check if leave dates spans a weekend.' }
  validates :leave_duration, comparison: { less_than: 30, message: 'Cannot have 30 days or more days of leave' }
  validates :user_id, presence: true

  def set_default_status
    self.leave_status = "Applied" if self.leave_status.blank?
  end

  def set_leave_duration
    wdays = [0,6] #weekend days by numbers on week
    self.leave_duration = (((self.start_date..self.end_date).reject { |d| wdays.include? d.wday}).count)
  end

  

end
