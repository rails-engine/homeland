require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Strategies::GitHub, '6cdd69717d7648e56110', 'dab5745aed84eaa2e03deb6a16da18fb825d228b'
Rails.application.config.middleware.use OmniAuth::Strategies::OpenID, OpenID::Store::Filesystem.new('/tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'

