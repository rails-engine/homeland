# coding: utf-8
require 'rails/generators'
module Homeland
  module Generators
    class ViewsGenerator < Rails::Generators::Base #:nodoc:
      source_root File.expand_path("../../../../app/views/homeland", __FILE__)
      desc "Used to copy Homeland's views to your application's views."

      def copy_views
        view_directory :replies
        view_directory :shared
        view_directory :topics
      end

      protected

      def view_directory(name)
        directory name.to_s, "app/views/homeland/#{name}"
      end
    end
  end
end
