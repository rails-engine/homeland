module Homeland
  module Markup
    # HTML raw format
    class Html < Base
      class << self
        def render(raw)
          raw
        end
      end
    end
  end
end
