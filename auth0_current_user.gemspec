require_relative 'lib/auth0_current_user/version'

Gem::Specification.new do |spec|
  spec.name          = 'auth0_current_user'
  spec.version       = Auth0CurrentUser::VERSION
  spec.authors       = ['Mike Heft']
  spec.email         = ['mikeheft@gmail.com']

  spec.summary       = "Implements Auth0's setup for authentication/authorization along with setting a current_user method."
  spec.description   = "Implements Auth0's setup for authentication/authorization along with setting a current_user method."
  spec.homepage      = 'https://github.com/mikeyduece/auth0_current_user'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = "'http://rubygems.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/mikeyduece/auth0_current_user'
  spec.metadata['changelog_uri'] = 'https://github.com/mikeyduece/auth0_current_user'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'jwt'
  spec.add_dependency 'request_store'
  spec.add_dependency 'uri'
  
end
