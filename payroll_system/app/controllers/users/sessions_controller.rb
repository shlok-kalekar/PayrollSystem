# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    respond_to :json

    private

    def respond_with(_resource, _options = {})
      render json: {
        status: { code: 200, message: 'User signed in successfully',
                  data: current_user }
      }, status: :ok,
      except: %i[created_at updated_at jti],
      include: ["role" => {:only => :role_type}]
    end

    def respond_to_on_destroy
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
                               Rails.application.credentials.fetch(:secret_key_base)).first
      current_user = User.find_by(jti: jwt_payload['jti'])
      if current_user
        render json: {
          status: 200,
          message: 'Signed out successfully'
        }, status: :ok
      else
        render json: {
          status: 401,
          message: 'User has no active session'
        }, status: :unauthorized
      end
    end
  end
end
