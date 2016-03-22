require 'test_helper'

module Homeland
  class MarkupTest < ActiveSupport::TestCase
    test '.render' do
      raw = %(hello *world*)
      assert_equal "<p>hello <em>world</em></p>\n", Markup.render(raw)
    end
  end
end
