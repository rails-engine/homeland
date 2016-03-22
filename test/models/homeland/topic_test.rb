require 'test_helper'

module Homeland
  class TopicTest < ActiveSupport::TestCase
    test '.set_last_active_mark' do
      topic = create(:topic)
      assert_not_nil topic.last_active_mark

      topic = build(:topic)
      t = Time.now
      Time.stub(:now, t) do
        topic.save
        assert_equal t.to_i, topic.last_active_mark
      end
    end

    test '.activity_at' do
      topic = build(:topic, replied_at: Time.now)
      assert_equal topic.replied_at, topic.activity_at

      topic.replied_at = nil
      assert_equal topic.updated_at, topic.activity_at

      topic.updated_at = nil
      assert_equal topic.created_at, topic.activity_at

      topic.created_at = nil
      assert_equal nil, topic.activity_at
    end

    test '.markdown on save' do
      topic = create(:topic, body: "Hello *world*")
      assert_equal topic.body_html, "<p>Hello <em>world</em></p>\n"
    end

    test 'soft delete' do
      topic = create(:topic)
      t = Time.now
      Time.stub(:now, t) do
        topic.destroy
        assert_equal t.to_i, topic.deleted_at.to_i
        assert_equal true, topic.deleted?
        assert_nil Topic.find_by(id: topic.id)
        assert_not_nil Topic.unscoped.find_by(id: topic.id)
      end
    end
  end
end
