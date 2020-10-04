# frozen_string_literal: true

require 'jwt'
require 'request_store'
require 'auth0_current_user/json_web_token'

module Auth0CurrentUser
  module Secured
    extend ActiveSupport::Concern

    included do
      before_action :authenticate_request!
    end

    private

    def authenticate_request!
      token = auth_token
      set_current_user(token)

      token
    rescue JWT::VerificationError, JWT::DecodeError
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    end

    def http_token
      if request.headers['Authorization'].present?
        request.headers['Authorization'].split(' ').last
      end
    end

    def auth_token
      JsonWebToken.verify(http_token)
    end

    def get_email(token)
      JsonWebToken.get_claim(token, 'email')
    end

    def set_current_user(token)
      email = get_email(token)
      RequestStore.store[:current_user] ||= User.find_by(email: email)
    end

    def current_user
      @current_user ||= RequestStore.store[:current_user]
    end

  end
end