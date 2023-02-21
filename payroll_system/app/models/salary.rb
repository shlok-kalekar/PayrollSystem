# frozen_string_literal: true

class Salary < ApplicationRecord

  belongs_to :user

  validates :total_salary, comparison: { greater_than_or_equal_to: 0, message: 'Cannot have negative salary' }
  validates :user_id, presence: true

end
