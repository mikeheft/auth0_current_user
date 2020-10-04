# frozen_string_literal: true
require 'net/http'
require 'uri'
require 'jwt'
require '../../lib/auth0_current_user/configuration'

class JsonWebToken
  def self.verify(token)
    JWT.decode(token, nil,
               true, # Verify the signature of this token
               algorithms: 'RS256',
               iss: configuration.auth0_domain,
               verify_iss: true,
               aud: configuration.auth0_audience,
               verify_aud: true) do |header|
      jwks_hash[header['kid']]
    end
  end

  def self.jwks_hash
    jwks_raw = Net::HTTP.get URI("#{configuration.auth0_domain}/.well-known/jwks.json")
    jwks_keys = Array(JSON.parse(jwks_raw)['keys'])
    Hash[
      jwks_keys
        .map do |k|
        [
          k['kid'],
          OpenSSL::X509::Certificate.new(
            Base64.decode64(k['x5c'].first)
          ).public_key
        ]
      end
    ]
  end

  def self.get_claim(token, claim_name)
    JWT.decode(token, nil, false).first[0][claim_name]
  end

  def self.configuration
    @configuration ||= Auth0CurrentUser::Configuration.new
  end
end
