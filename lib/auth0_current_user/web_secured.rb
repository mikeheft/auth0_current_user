require 'auth0_current_user/configuration'

module Auth0CurrentUser
  module WebSecured
    extend ActiveSupport::Concern

    included do
      before_action :logged_in_using_omniauth?
      helper_method :current_user
    end

    def current_user
      @_current_user ||= Kernel.const_get(authenticated_klass).find_by(email: email)
    end

    private

    def authenticated_klass
      unless configuration.authenticated_klass
        raise NotImplementedError, 'You must define the #authenitcated_klass in config/initializers/auth0_current_user'
        return
      end

      @_authenticated_klass ||= configuration.authenticated_klass.to_s.classify
    rescue NameError => e
      Rails.logger.error("You must create a #{authenticated_klass} model/migration")
    rescue StandardError => e
      Rails.logger.error(e.message)
    end

    def configuration
      @_configuration ||= Configuration.new
    end

    def email
      @_email ||= userinfo['email'] || userinfo['name']
    end

    def logged_in_using_omniauth?
      redirect_to authorization_endpoint unless session[:userinfo].present? && Time.zone.now < Time.zone.at(userinfo['exp'])
    end

    def authorization_endpoint
      @_authorization_endpoint ||= "https://#{configuration.auth0_domain}/authorize?response_type=code&client_id=#{configuration.client_id}"
    end

    def userinfo
      session['userinfo'] || {}
    end

    def configuration
      @configuration ||= Auth0CurrentUser.configuration
    end

  end
end

