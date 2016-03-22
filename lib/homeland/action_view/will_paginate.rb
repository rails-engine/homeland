require 'will_paginate/view_helpers/action_view'

module Homeland
  module ActionView
    module WillPaginate
      def homeland_paginate(collection = nil, options = {})
        options, collection = collection, nil if collection.is_a? Hash
        # Taken from original will_paginate code to handle if the helper is not passed a collection object.
        collection ||= infer_collection_from_controller
        options[:renderer] ||= BootstrapLinkRenderer
        options[:inner_window] ||= 2
        will_paginate(collection, options).try :html_safe
      end

      class BootstrapLinkRenderer < ::WillPaginate::ActionView::LinkRenderer
        protected

        def html_container(html)
          container_attributes[:class] = 'pagination'
          tag(:ul, html, container_attributes)
        end

        def page_number(page)
          tag :li, link(page, page, rel: rel_value(page), class: 'page-link'), class: (page == current_page ? 'page-item active' : 'page-item')
        end

        def gap
          tag :li, link('&hellip;'.html_safe, '#'), class: 'page-item disabled'
        end

        def previous_or_next_page(page, text, classname)
          tag :li, link(text, page || '#', class: 'page-link'),
              class: [(classname[0..3] if @options[:page_links]), ("page-item #{classname}" if @options[:page_links]), ('page-item disabled' unless page)].join(' ')
        end
      end
    end
  end
end
