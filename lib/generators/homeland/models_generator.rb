# coding: utf-8
require 'rails/generators'
module Homeland
  module Generators
    class ModelsGenerator < Rails::Generators::Base #:nodoc:
      source_root File.expand_path("../../../../app/models", __FILE__)
      desc "Used to copy Homeland's models to your application's models."

      def copy_models
        %w(node reply topic).each do |fname|
          path = "#{Rails.root}/app/models/homeland/#{fname}.rb"
          if File.exists?(path)
            puts "Skipping homeland/#{fname}.rb creation, as file already exists!"
          else
            puts "Adding model (homeland/#{fname}.rb)..."
            template "homeland/#{fname}.rb", path
          end
        end
      end
    end
  end
end
