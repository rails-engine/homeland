module Homeland
  class Reply < ActiveRecord::Base
    include Homeland::Concerns::SoftDelete
    include Homeland::Concerns::MarkdownBody

    belongs_to :user, class_name: Homeland.config.user_class.to_s
    belongs_to :topic, class_name: 'Homeland::Topic'

    validates :user_id, :body, :topic_id, presence: true

    scope :recent, -> { order('id desc') }

    after_commit :update_topic_last_reply_at, on: [:create, :update]
    def update_topic_last_reply_at
      self.topic.replied_at = Time.now
      self.topic.last_active_mark = Time.now.to_i
      self.topic.last_reply_user_id = self.user_id
      self.topic.replies_count = self.topic.replies.count
      self.topic.save
    end
  end
end
