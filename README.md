# Auth0CurrentUser
[![Gem Version](https://badge.fury.io/rb/auth0_current_user.svg)](https://badge.fury.io/rb/auth0_current_user)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'auth0_current_user'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install auth0_current_user

## Usage

After including the gem in your Gemfile, run `rails g auth0_current_user:install` to install the initializer. This configuration of the gem is dependant on a couple of attributes:
  * `auth0_domain`
    * This is the domain from setting up your Auth0 application.
  * `auth0_audience`
    * This is the api identifier that you chose when creating your api(M2M) application
  * `authenticated_klass`
    * Defaults to `User`, but if you have a different model name for the class that will be logging in and being authenticate, be sure to change that in the initializeer.
    * accepted values are symbols or strings
      * :user, 'user', :User, 'User'
      * :my_user, 'my_user', :MyUser, 'MyUser'

To take advantage of the Auth0 authentication there are two flows you can use by simply including the relevant module in which ever controller you wish to lockdown.
1. Web

   a. `include Auth0CurrentUser::WebSecured` 
3. Api

   a. `include Auth0CurrentUser::ApiSecured` 
  
In either case, you will have access to the `current_user` method. The `WebSecured` will check for `current_user` or `session['userinfo']` and the `ApiSecured` will check against the JsonWebToken being passed in.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/auth0_current_user. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/auth0_current_user/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Auth0CurrentUser project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/auth0_current_user/blob/master/CODE_OF_CONDUCT.md).
