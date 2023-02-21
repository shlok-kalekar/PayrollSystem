# frozen_string_literal: true

class TaxDeduction < ApplicationRecord

  belongs_to :user
  validates :user_id, presence: true

end
