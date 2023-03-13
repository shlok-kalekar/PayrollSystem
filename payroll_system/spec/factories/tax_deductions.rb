# frozen_string_literal: true

FactoryBot.define do
  factory :tax_deduction do
    deduct_type { 'NPS' }
    deduct_amount { 10_000 }
    financial_year { Faker::Date.between(from: '2017-01-01', to: '2023-02-01') }

    association :user
  end
end
