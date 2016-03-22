require 'test_helper'

module Homeland
  class ReplyTest < ActiveSupport::TestCase
    test '.recent' do
      assert_respond_to Homeland::Reply, :recent
    end

    test '.update_topic_last_reply_at' do
      reply = create(:reply)

      reply.stub(:topic, nil) do
        assert_equal nil, reply.update_topic_last_reply_at
      end

      t = Time.now

      Time.stub(:now, t) do
        assert_equal true, reply.update_topic_last_reply_at
      end
      assert_equal t.to_i, reply.topic.replied_at.to_i
      assert_equal t.to_i, reply.topic.last_active_mark
      assert_equal reply.user_id, reply.topic.last_reply_user_id
      assert_equal reply.topic.replies.count, reply.topic.replies_count
    end
  end
end
