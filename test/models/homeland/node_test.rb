require_relative '../../test_helper'

module Homeland
  class NodeTest < ActiveSupport::TestCase
    test '.root' do
      assert_difference "Node.root.count", +3 do
        create_list(:root_node, 3)
      end
    end
  end
end
