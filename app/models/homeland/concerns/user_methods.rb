module Homeland
  module Concerns
    module UserMethods
      extend ActiveSupport::Concern

      included do
      end

      def user_name
        @user_name ||= self.user && self.user.send(Homeland.config.user_name_method)
      end

      def user_avatar_url
        return nil if Homeland.config.user_avatar_method.blank?
        @user_avatar_url ||= self.user && self.user.send(Homeland.config.user_avatar_method)
      end

      def user_admin?
        @user_admin ||= self.user && self.user.send(Homeland.config.user_admin_method)
      end

      def user_profile_url
        @user_profile_url ||= self.user && self.user.send(Homeland.config.user_profile_url_method)
      end
    end
  end
end
