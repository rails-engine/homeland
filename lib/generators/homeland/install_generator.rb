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
        %w(jquery.hotkeys.js jquery.timeago.js).each do |fname|
          path = "#{Rails.root}/vendor/assets/javascripts/#{fname}"
          if File.exists?(path)
            puts "Skipping vendor/assets/javascripts/#{fname} creation, as file already exists!"
          else
            puts "Adding assets (vendor/assets/javascripts/#{fname})..."
            template "javascripts/#{fname}", path
          end
        end
      end
      
    end
	end
end