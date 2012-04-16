# coding: utf-8
module Homeland
  class Engine < ::Rails::Engine
    isolate_namespace Homeland
    
    config.homeland = ActiveSupport::OrderedOptions.new
    config.homeland.layout = "application"
    
    config.to_prepare do
      ::ApplicationHelper.class_eval do
        # Returns the current object.  This can be called from a layout or
        # view used with rails_blog_engine to access the containing
        # application's helpers.
        def app_helpers
          self
        end
      end
    end
    
    
    engine_name = "bbs"
  end
end