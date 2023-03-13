# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, # :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  belongs_to :role
  has_many :attendances
  has_many :leave_balances
  has_many :payslips
  has_many :salaries
  has_many :tax_deductions

  before_validation :set_default_role

  validates :full_name, presence: { message: I18n.t('blank') }
  validates :gender_type, presence: { message: I18n.t('blank') }
  validates :phone_no, presence: { message: I18n.t('blank') }, uniqueness: { message: I18n.t('unique') }
  validates :designation_type, presence: { message: I18n.t('blank') }
  validates :city_name, presence: { message: I18n.t('blank') }
  validates :join_date, comparison: { less_than: Date.today, message: 'Date should be previous to now' }
  validates :role_id, presence: true

  def set_default_role
    role.role_id = 2 if role_id.blank?
  end
end
