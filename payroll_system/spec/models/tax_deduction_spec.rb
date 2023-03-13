# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaxDeduction, type: :model do
  let!(:role) { create :role }
  let!(:role1) { create :role, role_type: 'Employee' }
  let!(:user) { create :user, role: }
  let!(:user1) { create :user, role: role1 }
  let!(:tax_deduction) { create :tax_deduction, user: user1 }
  let!(:tax_deduction1) { build :tax_deduction, deduct_amount: -100, user: user1 }

  it 'should be valid with all attributes' do
    expect(tax_deduction.valid?).to eq(true)
  end

  it 'should raise Record Invalid if negative error is sent' do
    expect { tax_deduction1.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
