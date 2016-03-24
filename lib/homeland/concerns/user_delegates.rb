module Homeland
  module Concerns
    module UserDelegates
      extend ActiveSupport::Concern

      included do
      end

      %w(user_name user_avatar_url user_profile_url).each do |method|
        define_method(method) do
          user_method = Homeland.config.send([method, "method"].join("_"))
          return nil if user_method.blank?
          return nil if self.user.blank?
          self.user.send(user_method)
        end
      end

      def user_admin?
        @user_admin ||= self.user && self.user.send(Homeland.config.user_admin_method) || false
      end
    end
  end
end
