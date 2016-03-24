module Homeland
  module Markup
    # Simple format, like Rails simple_format helper
    class Simple < Base
      class << self
        include ActionView::Helpers::TextHelper

        def render(raw)
          simple_format(raw, {}, sanitize: false)
        end
      end
    end
  end
end
