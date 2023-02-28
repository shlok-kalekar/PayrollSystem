class Role < ApplicationRecord

  has_many :users

  validates :role_type, presence: true, uniqueness: true

end