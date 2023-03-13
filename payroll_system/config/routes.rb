# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
    # registrations: 'users/registrations'
  }

  resources :users, :salaries, :tax_deductions, :attendances, :leave_balances, :payslips

  get '/users_emp', to: 'users#find_user_info'
  get '/salaries_emp', to: 'salaries#find_emp_salary'
  get '/leave_balances_emp', to: 'leave_balances#find_leaves'
  get '/attendances_emp', to: 'attendances#find_attendance'
  get '/tax_deductions_emp', to: 'tax_deductions#find_tax_deductions'
  get '/payslips_emp', to: 'payslips#find_payslips'
  put '/leave_balances_admin/:id', to: 'leave_balances#admin_update'
end
