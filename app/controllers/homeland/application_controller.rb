module Homeland
  class ApplicationController < ::ApplicationController
    helper Homeland::ActionView::WillPaginate
    helper Homeland::ApplicationHelper

    helper_method :current_user, :owner?, :admin?

    alias_method :origin_current_user, Homeland.config.current_user_method.to_sym
    alias_method :origin_authenticate_user!, Homeland.config.authenticate_user_method.to_sym

    def current_user
      origin_current_user
    end

    def authenticate_user!
      origin_authenticate_user!
    end

    def authorize_resource!(obj)
      if !owner?(obj)
        redirect_to homeland.root_path, alert: t('homeland.access_denied')
      end
    end

    def authorize_admin!
      if !admin?
        redirect_to homeland.root_path, alert: t('homeland.access_denied')
      end
    end

    def set_seo_meta(title = '', meta_keywords = '', meta_description = '')
      @page_title = "#{title}" if title.length > 0
      @meta_keywords = meta_keywords
      @meta_description = meta_description
    end

    def owner?(obj)
      return false if obj.blank?
      return false if current_user.blank?
      return true if current_user.send(Homeland.config.user_admin_method) == true

      obj.user_id == current_user.id
    end

    def admin?
      return false if current_user.blank?
      current_user.send(Homeland.config.user_admin_method) == true
    end
  end
end
