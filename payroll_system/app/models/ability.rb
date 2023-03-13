# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    case user.role.role_type
    when 'Administrator'
      can :manage, :all
    when 'Employee'
      can :find_user_info, User, id: user.id
      can :find_emp_salary, Salary, user_id: user.id
      can %i[find_leaves create update], LeaveBalance, user_id: user.id
      can %i[find_attendance create update], Attendance, user_id: user.id
      can %i[find_tax_deductions create update destroy], TaxDeduction, user_id: user.id
      can %i[find_payslips create destroy], Payslip, user_id: user.id
    else
      puts 'INVALID'
    end
  end
end
