module Homeland
  module Markup
    class Base
      class << self
        def render(raw)
          raise "Not implement render method."
        end
      end
    end
  end
end
