# coding: utf-8
module Homeland  
  module TopicsHelper
    def format_topic_body(text,title = "",allow_image = true)
      auto_link(simple_format(text),:all, :target => '_blank', :rel => "nofollow")
    end

    def topic_use_readed_text(state)
      case state
      when 0
        "在你读过以后还没有新变化"
      else
        "有新内容"
      end
    end
  end
end