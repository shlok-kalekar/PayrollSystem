# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    render json: { warning: exception, status: 'authorization_failed' } # , status:401
  end
end
