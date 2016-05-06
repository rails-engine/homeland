require 'rails/generators'
module Homeland
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Create Homeland's base files"
      source_root File.expand_path("../templates", __FILE__)

      def add_initializer
        path = "#{Rails.root}/config/initializers/homeland.rb"
        if File.exists?(path)
          puts "Skipping config/initializers/homeland.rb creation, as file already exists!"
        else
          puts "Adding Homeland initializer (config/initializers/homeland.rb)..."
          template "config/initializers/homeland.rb", path
        end
      end

      def add_routes
        route 'mount Homeland::Engine, at: "/homeland"'
      end

      def add_migrations
        exec("rake homeland:install:migrations")
      end
    end
  end
end
