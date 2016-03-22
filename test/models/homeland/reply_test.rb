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

    test '.per_page' do
      assert_equal Homeland.config.per_page, Reply.per_page
    end

    test '.markdown on save' do
      reply = create(:reply, body: "Hello *world*")
      assert_equal reply.body_html, "<p>Hello <em>world</em></p>\n"
    end

    test 'soft delete' do
      reply = create(:reply, body: "Hello *world*")
      t = Time.now
      Time.stub(:now, t) do
        reply.destroy
        assert_equal t.to_i, reply.deleted_at.to_i
        assert_nil Reply.find_by(id: reply.id)
        assert_not_nil Reply.unscoped.find_by(id: reply.id)
      end
    end
  end
end
