module Auth0CurrentUser
  class Configuration
    attr_accessor :auth0_domain, :auth0_audience, :authenticated_klass

    def initialize
      @auth0_domain = nil
      @auth0_audience = nil
      @authenticated_klass = :user
    end
    
  end

end
