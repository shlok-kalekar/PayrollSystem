# frozen_string_literal: true

class TaxDeduction < ApplicationRecord
  belongs_to :user

  before_validation :set_default_deduct_type

  validates :deduct_amount, comparison: { greater_than_or_equal_to: 0, message: 'Cannot have negative deduction' }
  validates :deduct_amount, :deduct_type, :financial_year, :user_id, presence: true

  def set_default_deduct_type
    self.deduct_type = 'Non-NPS'
  end
end
