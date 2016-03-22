require 'test_helper'

module Homeland
  class NodeTest < ActiveSupport::TestCase
    test '.badge_color' do
      node = Node.new
      assert_equal '#AAA', node.badge_color

      node.color = "#BBB"
      assert_equal '#BBB', node.badge_color
    end

    test '.badge_html' do
      node = Node.new
      assert_equal %(<i class="node-badge" style="background: #{node.badge_color};"></i>), node.badge_html
    end
  end
end
