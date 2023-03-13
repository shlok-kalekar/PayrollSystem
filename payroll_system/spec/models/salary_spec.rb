# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Salary, type: :model do
  context 'when creating a user' do
    let!(:role) { create :role }
    let!(:role1) { create :role, role_type: 'Employee' }
    let!(:user) { create :user, role: }
    let!(:user1) { create :user, role: role1 }
    let!(:salary) { build :salary, user: }
    let!(:salary1) { build :salary, monthly_salary: -100, user: user1 }
    let!(:salary2) { create :salary, user: user1, salary_month: '2023-01-01' }
    let!(:salary3) { build :salary, user: user1, salary_month: '2023-01-01' }

    it 'should be valid with all attributes' do
      expect(salary.valid?).to eq(true)
    end

    it 'should raise Record Invalid if record exists for the current month for a particular user' do
      expect(salary3.valid?).to eq(false)
    end

    it 'should raise Record Invalid if negative error is sent' do
      expect { salary1.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
