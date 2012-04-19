# coding: utf-8
module Homeland  
  module TopicsHelper
    def format_topic_body(text,title = "",allow_image = true)
      auto_link(simple_format(text),:all, :target => '_blank', :rel => "nofollow")
    end

    def render_topic_node_select_tag(topic, opts = {})
      return "" if topic.blank?
      grouped_collection_select(:topic, :node_id, Section.all,:sorted_nodes, :name, :id, :name, {:value => topic.node_id, :include_blank => false}, opts)
    end
  end
end