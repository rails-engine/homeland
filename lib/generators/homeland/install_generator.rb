require 'rails/generators'
module Homeland
  module Generators
    class InstallGenerator < Rails::Generators::Base
      
      source_root File.expand_path("../install/templates", __FILE__)
      
      def add_initializer
        path = "#{Rails.root}/config/initializers/homeland.rb"
        if File.exists?(path)
          puts "Skipping config/initializers/homeland.rb creation, as file already exists!"
        else
          puts "Adding Homeland initializer (config/initializers/homeland.rb)..."
          template "initializer.rb", path
        end
      end
      
      def add_javascripts
        %w(jquery.hotkeys.js jquery.timeago.js jquery.chosen.js).each do |fname|
          path = "#{Rails.root}/vendor/assets/javascripts/#{fname}"
          if File.exists?(path)
            puts "Skipping vendor/assets/javascripts/#{fname} creation, as file already exists!"
          else
            puts "Adding assets (vendor/assets/javascripts/#{fname})..."
            template "javascripts/#{fname}", path
          end
        end
      end

      def add_stylesheets
        %w(jquery.chosen.scss).each do |fname|
          path = "#{Rails.root}/vendor/assets/stylesheets/#{fname}"
          if File.exists?(path)
            puts "Skipping vendor/assets/stylesheets/#{fname} creation, as file already exists!"
          else
            puts "Adding assets (vendor/assets/stylesheets/#{fname})..."
            template "stylesheets/#{fname}", path
          end
        end
      end

      def add_images
        %w(jquery.chosen.png).each do |fname|
          path = "#{Rails.root}/vendor/assets/images/#{fname}"
          if File.exists?(path)
            puts "Skipping vendor/assets/images/#{fname} creation, as file already exists!"
          else
            puts "Adding assets (vendor/assets/images/#{fname})..."
            template "images/#{fname}", path
          end
        end
      end
      
      def add_locales
        %w(zh-CN.yml).each do |fname|
          path = "#{Rails.root}/config/locales/homeland.#{fname}"
          if File.exists?(path)
            puts "Skipping config/locales/homeland.#{fname} creation, as file already exists!"
          else
            puts "Adding assets (config/locales/homeland.#{fname})..."
            template "locales/homeland.#{fname}", path
          end
        end
      end
      
      
    end
	end
end