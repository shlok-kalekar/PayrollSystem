# frozen_string_literal: true

FactoryBot.define do
  factory :payslip do
    attendance_cut { Faker::Number.positive }
    remaining_salary { Faker::Number.positive }
    tot_tax { Faker::Number.positive }
    payable_salary { Faker::Number.positive }
    slip_month { Faker::Date.between(from: '2017-01-01', to: '2023-02-01') }

    association :user
  end
end
