# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LeaveBalance, type: :model do
  let!(:role) { create :role }
  let!(:role1) { create :role, role_type: 'Employee' }
  let!(:user) { create :user, role: }
  let!(:user1) { create :user, role: role1 }
  let(:leave_balance) { build :leave_balance, user: user1 }
  let(:leave_balance1) { build :leave_balance, user: user1, start_date: '2023-02-06', end_date: '2023-02-05' }
  let(:leave_balance2) { create :leave_balance, user: user1, start_date: '2023-02-18', end_date: '2023-02-21' }
  let(:leave_balance3) { build :leave_balance, user: user1, start_date: '2023-02-20', end_date: '2023-02-24' }

  it 'should be valid with all attributes' do
    expect(leave_balance.valid?).to eq(true)
  end

  it 'should raise RecordInvalid when End Date is smaller than Start Date' do
    expect { leave_balance1.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should be invalid when there is overlap of dates' do
    leave_balance2.save!
    expect(leave_balance3.valid?).to eq(false)
  end
end
