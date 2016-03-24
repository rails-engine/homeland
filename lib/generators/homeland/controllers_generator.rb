# coding: utf-8
require 'rails/generators'
module Homeland
  module Generators
    class ControllersGenerator < Rails::Generators::Base #:nodoc:
      source_root File.expand_path("../../../../app/controllers", __FILE__)
      desc "Used to copy Homeland's views to your application's views."

      def copy_controllers
        directory 'homeland', "app/controllers/homeland"
      end
    end
  end
end
