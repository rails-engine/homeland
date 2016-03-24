module Homeland
  module Markup
    # Markdown format (github-markup)
    class Markdown < Base
      class << self
        def render(raw)
          begin
            require 'github/markup'
          rescue
            puts "Error: You need add `gem 'github-markup'` into you Gemfile."
          end
          GitHub::Markup.render('raw.md', raw)
        end
      end
    end
  end
end
