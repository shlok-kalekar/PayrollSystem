# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :jwt_authenticatable, jwt_revocation_strategy: self
  validates :first_name, :last_name, presence: true , on: :update
  validates :tot_paid_leaves, numericality: { only_integer: true }, on: :update

  def jwt_payload
    super
  end

end
