# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    private

    def respond_with(resource, _options = {})
      if resource.persisted?
        render json: {
          status: { code: 200, message: 'Signed Up Successfully', data: resource }
        }, status: :ok
      else
        render json: {
          status: { message: 'User could not be created successfully',
                    errors: resources.errors.full_messages }, status: :unprocessable_entity
        }
      end
    end
  end
end
