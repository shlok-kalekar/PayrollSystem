# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payslip, type: :model do
  let!(:role) { create :role }
  let!(:role1) { create :role, role_type: 'Employee' }
  let!(:user) { create :user, role: }
  let!(:user1) { create :user, role: role1 }
  let!(:payslip) { create :payslip, user: user1 }
  let!(:payslip1) { build :payslip, user: user1, attendance_cut: -10 }
  let!(:payslip2) { build :payslip, user: user1, remaining_salary: -10 }
  let!(:payslip3) { build :payslip, user: user1, tot_tax: -10 }
  let!(:payslip4) { build :payslip, user: user1, payable_salary: -10 }

  it 'should be valid with all attributes' do
    expect(payslip.valid?).to eq(true)
  end

  it 'should raise Record Invalid if negative attendance_cut is sent' do
    expect { payslip1.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should raise Record Invalid if negative remaining_salary is sent' do
    expect { payslip2.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should raise Record Invalid if negative tot_tax is sent' do
    expect { payslip3.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should raise Record Invalid if negative payable_salary is sent' do
    expect { payslip4.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
