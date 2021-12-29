module Auth0CurrentUser
  module WebSecured
    extend ActiveSupport::Concern

    included do
      helper_method :current_user
      before_action :logged_in_using_omniauth?
    end

    def current_user
      @_current_user ||= RequestStore.store[:current_user] ||= Kernel.const_get(authenticated_klass).find_by(email: email) 
    end

    private

    def authenticated_klass
      unless configuration.authenticated_klass
        raise NotImplementedError, 'You must define the #authenitcated_klass in config/initializers/auth0_current_user'
        return
      end

      @authenticated_klass ||= configuration.authenticated_klass.to_s.classify
    rescue NameError => e
      Rails.logger.error("You must create a #{authenticated_klass} model/migration")
    rescue StandardError => e
      Rails.logger.error(e.message)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def email
      @_email ||= session.dig(:userinfo, :email)
    end

    def logged_in_using_omniauth?
      redirect_to '/' unless current_user || session[:userinfo].present?
    end

  end
end

