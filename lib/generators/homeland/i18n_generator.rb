require 'rails/generators'
module Homeland
  module Generators
    class I18nGenerator < Rails::Generators::Base
      desc "Create Homeland's default I18n files"
      source_root File.expand_path("../../../../", __FILE__)

      def add_locales
        %w(en.yml zh-CN.yml).each do |fname|
          path = "#{Rails.root}/config/locales/homeland.#{fname}"
          if File.exists?(path)
            puts "Skipping config/locales/homeland.#{fname} creation, as file already exists!"
          else
            puts "Adding locale (config/locales/homeland.#{fname})..."
            template "config/locales/homeland.#{fname}", path
          end
        end
      end

    end
  end
end
