require 'will_paginate'
require 'will_paginate/active_record'

module Homeland
  module Concerns
    module Pagination
      extend ActiveSupport::Concern

      included do
        self.per_page = Homeland.config.per_page
      end
    end
  end
end
