# coding: utf-8
require 'rails/generators'
module Homeland
  module Generators
    class ViewsGenerator < Rails::Generators::Base #:nodoc:
      source_root File.expand_path("../../../../app/views", __FILE__)
      desc "Used to copy Homeland's views to your application's views."

      def copy_views
        directory 'homeland', "app/views/homeland"
        directory 'layouts/homeland', "app/views/layouts/homeland"
      end
    end
  end
end
