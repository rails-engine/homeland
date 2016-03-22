require 'test_helper'

class NodeTest < ActiveSupport::TestCase
  test '.count' do
    assert_difference "Node.count", +3 do
      create_list(:node, 3)
    end
  end
end
