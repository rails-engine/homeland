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
  end
end