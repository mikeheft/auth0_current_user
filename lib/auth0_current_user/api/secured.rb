# frozen_string_literal: true

require 'jwt'
require 'request_store'
require 'auth0_current_user/json_web_token'
require 'auth0_current_user/configuration'

module Auth0CurrentUser::Api::Secured
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
    RequestStore.store[:current_user] ||= Kernel.const_get(authenticated_klass).find_by(email: email)
  end

  def current_user
    @current_user ||= RequestStore.store[:current_user]
  end

  def authenticated_klass
    unless configuration.authenticated_klass
      raise NotImplementedError, 'You must define the #authenitcated_klass in config/initializers/auth0_current_user'
      return
    end

    @authenticated_klass ||= configuration.authenticated_klass.to_s.classify
  rescue StandardError => e
    Rails.logger.error(e.message)
  end

  def configuration
    @configuration ||= Configuration.new
  end

end
