# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when creating a user' do
    let(:role) { create :role }
    let(:role1) { create :role, role_type: 'Employee' }
    let(:user) { build :user, role: }
    let(:user1) { create :user, role: nil }
    let(:user2) { build :user, email: user.email, phone_no: user.phone_no, role: role1 }
    let(:user3) { build :user, role: role1 }

    it 'should be valid with all attributes' do
      expect(user.valid?).to eq(true)
    end

    # it 'should have role_id equal to 2 if role_id is nil' do
    #   expect(user1.role.role_type).to eq("Employee")
    # end

    it 'should raise invalid record exception for duplicate email and phone_no' do
      user.save
      expect(user2.save).to eq(false)
      expect { user2.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should not be valid if current_date is lesser than join_date' do
      user3.join_date = Date.today
      expect(user3.valid?).to eq(false)
    end
  end
end
