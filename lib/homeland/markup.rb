require 'github/markup'

module Homeland
  module Markup
    class << self
      def render(text)
        GitHub::Markup.render('text.md', text)
      end
    end
  end
end
