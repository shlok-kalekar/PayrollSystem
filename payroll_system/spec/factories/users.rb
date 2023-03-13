# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: User do
    full_name { Faker::Name.name }
    gender_type { Faker::Gender.type }
    phone_no { Faker::PhoneNumber.cell_phone_with_country_code }
    designation_type { Faker::Job.title }
    city_name { Faker::Address.city }
    join_date { Faker::Date.between(from: '2017-01-01', to: '2023-02-01') }
    tot_paid_leaves { Faker::Number.between(from: 5, to: 15) }
    email { Faker::Internet.email }
    password { 123_456 }

    association :role
  end
end
