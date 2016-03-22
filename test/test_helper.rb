ENV['RAILS_ENV'] ||= 'test'

require 'rails'
require 'factory_girl_rails'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
end
