# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require "rspec/rails"
require 'rspec/autorun'
require "capybara/rails"

# Load support files
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f }

# Configure capybara for integration testing
Capybara.default_driver   = :rack_test
Capybara.default_selector = :css

# Run any available migration
# ActiveRecord::Migrator.migrate File.expand_path("../dummy/db/migrate/", __FILE__)

module DeviseUserHelper
  include Capybara

  def sign_in_as(email = "foobar@gmail.com", password = "123123")
    user = User.create(:password => password, :password_confirmation => password, :email => email)
    user.save!
    visit '/users/sign_in'
    fill_in 'Email', :with => email
    fill_in 'Password', :with => password
    click_link_or_button('Sign in')
    user
  end

  def sign_out
    click_link_or_button('Sign out')
  end
end

RSpec.configure do |config|
  # Remove this line if you don't want RSpec's should and should_not
  # methods or matchers
  require 'rspec/expectations'
  config.mock_with :rspec
  config.include Factory::Syntax::Methods
  config.include RSpec::Matchers
  config.include DeviseUserHelper, :type => :request

  config.before do
    # Initialize nodes
    user = FactoryGirl.create(:user)
    # section = FactoryGirl.create(:section)
    # FactoryGirl.create(:node, :section => section)
    # FactoryGirl.create(:node, :section => section)
  end
end
