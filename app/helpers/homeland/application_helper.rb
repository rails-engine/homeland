module Homeland
  module ApplicationHelper
    DEFAULT_AVATAR = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAPAAAADwCAMAAAAJixmgAAAAFVBMVEWkpKSnp6eqqqq3t7fS0tLV1dXZ2dmshcKEAAAAtklEQVR4Ae3XsRGAAAjAQFRk/5HtqaTz5H+DlInvAQAAAAAAAAAAAAAAAAAAAACymiveO6o7BQsWLFiwYMGCBS8PFixYsGDBggULFixYsGDBggULFixYsGDBggULFixYsGDBc4IFCxYsWLBgwYIFC14ZfOeAPRQ8IliwYMGCBQsWLFiwYMGCBQsWLFiwYMGCBQsWLFiwYMGCBQsWLFiwYMGCBQv+JQAAAAAAAAAAAAAAAAAAAOAB4KJfdHmj+kwAAAAASUVORK5CYII='

    def render_errors(target)
      if target.errors.present?
        render partial: '/homeland/shared/error_messages', locals: { target: target }
      end
    end

    def timeago(time, options = {})
      options[:class] ||= "timeago"
      content_tag(:abbr, time.to_s, options.merge(:title => time.getutc.iso8601)) if time
    end

    def node_tag(node)
      return '' if node.blank?

      label = [node.badge_html, content_tag(:span, node.name, class: 'name')].join(' ')

      link_to raw(label), homeland.node_topics_path(node.id), class: 'node'
    end

    def user_name_tag(obj)
      return '' if obj.blank?
      return '' if obj.user_name.blank?

      link_to obj.user_name, obj.user_profile_url, class: 'user-name'
    end

    def user_avatar_tag(obj, opts = {})
      default = image_tag(DEFAULT_AVATAR, class: 'avatar media-object')
      return default if obj.blank?
      return default if obj.user.blank?

      if obj.user_avatar_url == nil
        img = default
      else
        img = image_tag(obj.user_avatar_url, class: 'avatar media-object')
      end

      link_to img, obj.user_profile_url, title: obj.user_name, class: 'user-avatar'
    end

    def notice_message
      flash_messages = []

      flash.each do |type, message|
        type = :danger
        type = :success if type.to_sym == :notice
        close_button = raw %(<button type="button" class="close" data-dismiss="alert">×</button>)
        text = content_tag(:div, close_button + message, class: "alert alert-dismissible alert-#{type}")
        flash_messages << text if message
      end

      flash_messages.join("\n").html_safe
    end
  end
end
