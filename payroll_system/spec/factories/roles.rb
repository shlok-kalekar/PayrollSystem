# frozen_string_literal: true

FactoryBot.define do
  factory :role, class: Role do
    role_type { 'Administrator' }
  end
end
