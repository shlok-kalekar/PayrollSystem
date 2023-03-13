# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  let(:role) { create :role }
  let(:role1) { build :role, role_type: 'Employee' }
  let(:role2) { build :role, role_type: 'Employee' }

  it 'should be valid with all attributes' do
    expect(role.valid?).to eq(true)
  end

  it 'should be invalid when there is the same role name' do
    role1.save!
    expect(role2.valid?).to eq(false)
  end
end
