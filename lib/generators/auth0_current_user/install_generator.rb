require 'rails/generators/base'

module Auth0CurrentUser
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../../templates', __FILE__ )

    def self.exit_on_failure
      true
    end

    def install_auth0_current_user
      template 'auth0_current_user.rb', 'config/initializers/auth0_current_user.rb'
    end
  end

end
