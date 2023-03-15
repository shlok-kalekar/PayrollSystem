# frozen_string_literal: true

require 'rails_helper'
require 'support/factory_bot'

RSpec.describe UsersController, type: :controller do
  context 'GET /users' do
    let!(:role) { create :role, role_type: 'Administrator' }
    let!(:role1) { create :role, role_type: 'Employee' }
    let!(:admin_user) { create :user, role: }
    let!(:user) { create :user, role: role1 }

    before do
      sign_in(admin_user)
    end

    it 'should return all users details' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  context 'GET /show' do
    let!(:role) { create :role, role_type: 'Administrator' }
    let!(:role1) { create :role, role_type: 'Employee' }
    let!(:admin_user) { create :user, role: }
    let!(:user) { create :user, role: role1 }

    before do
      sign_in(admin_user)
    end

    it 'should successfully show admin user' do
      get :show, params: { id: admin_user.id }
      expect(response.status).to eq(200)
    end

    it 'should successfully show employee user' do
      get :show, params: { id: user.id }
      expect(response.status).to eq(200)
    end

    # it 'should throw error when not found user id' do
    #   get :show, params: { id: Faker::Number.number(digits: 2) }
    #   expect((response.status)).to eq(404)
    # end
  end

  context 'GET signed in /users_emp' do
    let!(:role) { create :role }
    let!(:role1) { create :role, role_type: 'Employee' }
    let!(:user) { create :user, role: }
    let!(:current_user) { create :user, role: role1 }

    it 'should successfully show user info' do
      sign_in(current_user)
      get :find_user_info
      expect(response.status).to eq(200)
    end

    it 'should ask for sign in ' do
      get :find_user_info
      expect(response.status).to eq(401)
    end
  end

  context 'POST /users' do
    let!(:role) { create :role }
    let!(:role1) { create :role, role_type: 'Employee' }
    let!(:valid_user) { create :user, role: }
    let!(:invalid_user) { create :user, role: role1 }

    before do
      sign_in(valid_user)
    end

    it 'creates a new user' do
      post :create, params: { user: {
        full_name: Faker::Name.name,
        gender_type: Faker::Gender.type,
        phone_no: Faker::PhoneNumber.cell_phone_with_country_code,
        designation_type: Faker::Job.title,
        city_name: Faker::Address.city,
        join_date: Faker::Date.between(from: '2017-01-01', to: '2023-02-01'),
        tot_paid_leaves: Faker::Number.between(from: 5, to: 15),
        email: Faker::Internet.email,
        password: Faker::Internet.password
      } }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['message']).to eq('Successfully added data')
    end

    it 'should not create new user without email' do
      post :create, params: { user: {
        full_name: Faker::Name.name,
        gender_type: Faker::Gender.type,
        phone_no: Faker::PhoneNumber.cell_phone_with_country_code,
        designation_type: Faker::Job.title,
        city_name: Faker::Address.city,
        join_date: Faker::Date.between(from: '2017-01-01', to: '2023-02-01'),
        tot_paid_leaves: Faker::Number.between(from: 5, to: 15),
        email: nil,
        password: '123456'
      } }
      expect(response.status).to eq(200) # why
      expect(JSON.parse(response.body)['message']).to eq('FAILED!')
    end

    it 'should not create new user without password' do
      post :create, params: { user: {
        full_name: Faker::Name.name,
        gender_type: Faker::Gender.type,
        phone_no: Faker::PhoneNumber.cell_phone_with_country_code,
        designation_type: Faker::Job.title,
        city_name: Faker::Address.city,
        join_date: Faker::Date.between(from: '2017-01-01', to: '2023-02-01'),
        tot_paid_leaves: Faker::Number.between(from: 5, to: 15),
        email: Faker::Internet.email,
        password: nil
      } }
      expect(response.status).to eq(200) # why
      expect(JSON.parse(response.body)['message']).to eq('FAILED!')
    end

    it 'employee unable to create new user' do
      sign_out(valid_user)
      sign_in(invalid_user)
      post :create, params: { user: {
        full_name: Faker::Name.name,
        gender_type: Faker::Gender.type,
        phone_no: Faker::PhoneNumber.cell_phone_with_country_code,
        designation_type: Faker::Job.title,
        city_name: Faker::Address.city,
        join_date: Faker::Date.between(from: '2017-01-01', to: '2023-02-01'),
        tot_paid_leaves: Faker::Number.between(from: 5, to: 15),
        email: Faker::Internet.email,
        password: Faker::Internet.password
      } }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['status']).to eq('authorization_failed')
    end
  end

  context 'PUT update' do
    let!(:role) { create :role }
    let!(:role1) { create :role, role_type: 'Employee' }
    let!(:admin_user) { create :user, role: }
    let!(:user) { create :user, role: role1 }

    before do
      sign_in(admin_user)
    end

    it 'should update user' do
      put :update, params: {
        user: {
          full_name: Faker::Name.name,
          gender_type: Faker::Gender.type,
          phone_no: Faker::PhoneNumber.cell_phone_with_country_code,
          designation_type: Faker::Job.title,
          city_name: Faker::Address.city,
          join_date: Faker::Date.between(from: '2017-01-01', to: '2023-02-01'),
          tot_paid_leaves: Faker::Number.between(from: 5, to: 15),
          email: Faker::Internet.email,
          password: Faker::Internet.password
        }, id: user.id
      }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['message']).to eq('Successfully updated data!')
    end

    it 'should not update the user with nil field' do
      put :update, params: {
        user: {
          full_name: nil,
          gender_type: Faker::Gender.type,
          phone_no: Faker::PhoneNumber.cell_phone_with_country_code,
          designation_type: Faker::Job.title,
          city_name: Faker::Address.city,
          join_date: Faker::Date.between(from: '2017-01-01', to: '2023-02-01'),
          tot_paid_leaves: Faker::Number.between(from: 5, to: 15),
          email: Faker::Internet.email,
          password: Faker::Internet.password
        }, id: user.id
      }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['message']).to eq('FAILED!')
    end

    it 'should not allow user who is not admin to update' do
      sign_out(admin_user)
      sign_in(user)
      put :update, params: {
        user: {
          full_name: Faker::Name.name,
          gender_type: Faker::Gender.type,
          phone_no: Faker::PhoneNumber.cell_phone_with_country_code,
          designation_type: Faker::Job.title,
          city_name: Faker::Address.city,
          join_date: Faker::Date.between(from: '2017-01-01', to: '2023-02-01'),
          tot_paid_leaves: Faker::Number.between(from: 5, to: 15),
          email: Faker::Internet.email,
          password: Faker::Internet.password
        }, id: user.id
      }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['status']).to eq('authorization_failed')
    end
  end

  context 'DELETE destroy' do
    let!(:role) { create :role }
    let!(:role1) { create :role, role_type: 'Employee' }
    let!(:admin_user) { create :user }
    let!(:user) { create :user, role: role1 }
    let!(:user1) { create :user, role: role1 }

    it 'should deactivate user' do
      sign_in(admin_user)
      delete :destroy, params: { id: user.id }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['message']).to eq('Successfully deleted data!')
    end

    it 'should not allow use of if unauthorised' do
      sign_in(user)
      delete :destroy, params: { id: user1.id }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['status']).to eq('authorization_failed')
    end
  end
end
