# coding: utf-8
require 'rails/generators'
module Homeland
  module Generators
    class ControllersGenerator < Rails::Generators::Base #:nodoc:
      source_root File.expand_path("../../../../app/controllers", __FILE__)
      desc "Used to copy Homeland's controllers to your application's controllers."

      def copy_controllers
        %w(nodes replies topics).each do |fname|
          path = "#{Rails.root}/app/controllers/homeland/#{fname}_controller.rb"
          if File.exists?(path)
            puts "Skipping homeland/#{fname}_controller.rb creation, as file already exists!"
          else
            puts "Adding model (homeland/#{fname}_controller.rb)..."
            template "homeland/#{fname}_controller.rb", path
          end
        end
      end
    end
  end
end
