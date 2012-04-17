# coding: utf-8
require 'active_support/core_ext/kernel/singleton_class'

module Homeland
  mattr_accessor :app_name, :per_page, :user_class, :current_user_method, :require_user_method,
                 :user_path_method, :user_avatar_method
  
  class << self
    def app_name
      @@app_name || "Forum"
    end
    
    def per_page
      @@per_page || 20
    end
    
    def user_class
      (@@user_class || "User").constantize
    end
    
    def current_user_method
      @@current_user_method || "current_user"
    end
    
    def require_user_method
      @@require_user_method || "require_user"
    end
    
    def user_path_method
      @@user_path_method || "user_path"
    end
    
    def user_avatar_method
      @@user_avatar_method || "avatar"
    end
  end
end