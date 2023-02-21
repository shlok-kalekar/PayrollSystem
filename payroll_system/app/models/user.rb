# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  belongs_to :role
  has_many :attendances
  has_many :leaves
  has_many :payslips
  has_many :salaries
  has_many :tax_deductions

  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :validatable, 
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :first_name, presence: { message: I18n.t('blank') }
  validates :last_name, presence: { message: I18n.t('blank') }
  validates :gender_type, presence: { message: I18n.t('blank') }
  validates :phone_no , presence: { message: I18n.t('blank') } , uniqueness: { message: I18n.t('unique') }, length: { is: 10 }
  validates :designation_type, presence: { message: I18n.t('blank') }
  validates :city_name, presence: { message: I18n.t('blank') }
  validates :join_date, comparison: { less_than: Date.today, message: 'Date should be previous to now' }
  validates :role_id, presence: true

  belongs_to :role

  def jwt_payload
    super
  end

end
