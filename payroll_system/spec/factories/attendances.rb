# frozen_string_literal: true

FactoryBot.define do
  factory :attendance do
    attendance_month { Faker::Date.between(from: '2017-01-01', to: '2023-02-01') }
    tot_work_days { 20 }
    unpaid_leaves { Faker::Number.within(range: 1..10) }
    attend_rate { Faker::Number.within(range: 1..100) }

    association :user
  end
end
