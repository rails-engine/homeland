require 'homeland/markup/base'
require 'homeland/markup/html'
require 'homeland/markup/markdown'
require 'homeland/markup/simple'

module Homeland
  module Markup
    class << self
      # Convert Topic, Reply content with custom format
      def render(raw)
        const_name = "Homeland::Markup::#{Homeland.config.markup.to_s.classify}"
        klass = const_name.constantize
        klass.render(raw)
      end
    end
  end
end
