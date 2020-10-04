# Add your Auth0 audience and domain here to ensure that the gem can authenticate the request against your app
Auth0CurrentUser.config do |c|
  c.auth0_domain = '<REPLACE ME WITH YOUR AUTH0 DOMAIN>'
  c.auth0_audience = '<REPLACE ME WITH YOUR AUTH0 AUDIENCE>'
  # This gem assumes you have a model named User. If you are using a different name for the class to be authenticated,
  # simply change is here.
  # c.authenticated_klass = :user
end
