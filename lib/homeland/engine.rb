module Homeland
  class Engine < ::Rails::Engine
    isolate_namespace Homeland

    initializer "homeland.i18n.load_path" do |app|
      app.config.i18n.load_path += Dir["#{Rails.root}/config/locales/**/*.yml"]
    end
  end
end
