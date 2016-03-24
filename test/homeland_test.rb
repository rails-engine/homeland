require 'test_helper'

class HomelandTest < ActiveSupport::TestCase
  test 'VERSION' do
    assert_not_nil Homeland::VERSION
  end

  test '.config' do
    assert_instance_of Homeland::Configuration, Homeland.config

    config = Homeland.config
    assert_equal :markdown, config.markup
    assert_equal 'Homeland', config.app_name
    assert_equal 'User', config.user_class
    assert_equal 'name', config.user_name_method
    assert_equal 'avatar_url', config.user_avatar_url_method
    assert_equal 'admin?', config.user_admin_method
    assert_equal 'profile_url', config.user_profile_url_method
    assert_equal 'authenticate_user!', config.authenticate_user_method
    assert_equal 'current_user', config.current_user_method
  end
end
