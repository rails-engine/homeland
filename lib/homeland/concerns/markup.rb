module Homeland
  module Concerns
    module Markup
      extend ActiveSupport::Concern

      included do
        before_save :render_markup
      end

      def render_markup
        if self.body_changed?
          self.body_html = Homeland::Markup.render(self.body)
        end
      end
    end
  end
end
