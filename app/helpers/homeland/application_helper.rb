# coding: utf-8
module Homeland
  module ApplicationHelper
    def owner?(item)
      return false if item.blank?
      return if current_user.blank?
      item.user_id == current_user.id
    end

    def timeago(time, options = {})
      options[:class] ||= "timeago"
      content_tag(:abbr, time.to_s, options.merge(:title => time.getutc.iso8601)) if time
    end

    def user_name_tag(user,options = {})
      return "" if user.blank?
      link_to_if(Homeland.user_path_method, user.name, [main_app, user])
    end

    def user_avatar_tag(user)
      return "" if user.blank?
      img = image_tag(user.try(Homeland.user_avatar_method.to_sym))
      link_to_if(Homeland.user_path_method, raw(img), [main_app, user])
    end

  end
end