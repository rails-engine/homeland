require 'test_helper'

module Homeland
  module Concerns
    class UserMethodsTest < ActiveSupport::TestCase
      class Monkey
        include Homeland::Concerns::UserDelegates

        attr_accessor :user
      end

      setup do
        @user = build(:user, id: 10)
      end

      test '.user_name' do
        monkey = Monkey.new
        assert_equal nil, monkey.user_name

        monkey.stub(:user, @user) do
          @user.stub(Homeland.config.user_name_method, "Bob") do
            assert_equal "Bob", monkey.user_name
          end
        end
      end

      test '.user_avatar_url' do
        monkey = Monkey.new
        assert_equal nil, monkey.user_avatar_url

        monkey.stub(:user, @user) do
          @user.stub(Homeland.config.user_avatar_url_method, 'http://www.google.com') do
            assert_equal 'http://www.google.com', monkey.user_avatar_url
          end
        end
      end

      test '.user_admin?' do
        monkey = Monkey.new
        assert_equal false, monkey.user_admin?

        monkey.stub(:user, @user) do
          @user.stub(Homeland.config.user_admin_method, true) do
            assert_equal true, monkey.user_admin?
          end
        end
      end
    end
  end
end
