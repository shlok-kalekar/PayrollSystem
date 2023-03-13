# frozen_string_literal: true

FactoryBot.define do
  factory :salary do
    monthly_salary { Faker::Number.within(range: 500_000..1_200_000) }
    salary_month { Faker::Date.between(from: '2017-01-01', to: '2023-02-01') }

    association :user
  end
end
