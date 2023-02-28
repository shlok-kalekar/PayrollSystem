# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role.role_type.eql?('Administrator')
      can :manage, :all
    elsif
      # can :manage, ModelName
      # can :read, ModelName
    end
  end
end
