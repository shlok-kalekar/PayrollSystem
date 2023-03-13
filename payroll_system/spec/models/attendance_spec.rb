# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Attendance, type: :model do
  let!(:role) { create :role }
  let!(:role1) { create :role, role_type: 'Employee' }
  let!(:user) { create :user, role: }
  let!(:user1) { create :user, role: role1 }
  let!(:attendance) { create :attendance, user: user1 }
  let!(:attendance1) { build :attendance, user: user1, tot_work_days: -20 }
  let!(:attendance2) { create :attendance, user: user1, attendance_month: '2023-01-01' }
  let!(:attendance3) { build :attendance, user: user1, attendance_month: '2023-01-01' }
  let!(:attendance4) { build :attendance, user:, attendance_month: '2023-01-01' }

  it 'should be valid with all attributes' do
    expect(attendance.valid?).to eq(true)
  end

  it 'should raise Record Invalid if record exists for the current month for a particular user' do
    attendance2.save!
    expect(attendance3.valid?).to eq(false)
  end

  it 'should be valid if its different user' do
    attendance2.save!
    expect(attendance4.valid?).to eq(true)
  end

  it 'should raise Record Invalid if negative error is sent' do
    expect { attendance1.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
