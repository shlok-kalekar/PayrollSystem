# frozen_string_literal: true

FactoryBot.define do
  factory :leave_balance do
    start_date { '2023-01-12' }
    end_date { '2023-01-14' }
    leave_type { 'Unpaid' }
    leave_details { 'No Comment' }
    leave_duration { Faker::Number.within(range: 0...30) }
    leave_status { 'Applied' }

    association :user
  end
end
