ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)
require 'rails/test_help'
require 'factory_girl_rails'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
end
