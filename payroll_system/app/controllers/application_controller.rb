# frozen_string_literal: true

class ApplicationController < ActionController::API

  rescue_from CanCan::AccessDenied do |exception|
    render json: { warning: exception, status: 'authorization_failed'}, status:401
  end

end
