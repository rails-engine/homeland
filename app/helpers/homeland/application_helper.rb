module Homeland
  module ApplicationHelper
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

      link_to raw(label), homeland.node_topics_path(node.id)
    end
  end
end
