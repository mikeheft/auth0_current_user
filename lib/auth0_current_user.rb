require 'auth0_current_user/version'
require 'auth0_current_user/configuration'
require 'auth0_current_user/api_secured'
require 'auth0_current_user/web_secured'

module Auth0CurrentUser
  class Error < StandardError; end

  # Configuration Setup
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.config
    yield(configuration)
  end

end
