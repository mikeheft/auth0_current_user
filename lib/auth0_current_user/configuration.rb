module Auth0CurrentUser
  class Configuration
    attr_accessor :auth0_domain, :auth0_audience

    def initialize
      @auth0_domain = nil
      @auth0_audience = nil
    end
    
  end

end
