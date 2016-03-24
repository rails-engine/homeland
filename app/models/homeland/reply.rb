module Homeland
  class Reply < ActiveRecord::Base
    include Homeland::Concerns::SoftDelete
    include Homeland::Concerns::Markup
    include Homeland::Concerns::UserDelegates

    self.per_page = Homeland.config.per_page

    belongs_to :user, class_name: Homeland.config.user_class.to_s
    belongs_to :topic, class_name: 'Homeland::Topic'
    belongs_to :reply_to, class_name: 'Homeland::Reply'

    has_many :replies, class_name: "Homeland::Reply", foreign_key: "reply_to_id"

    validates :user_id, :body, :topic_id, presence: true

    scope :recent, -> { order('id desc') }

    after_commit :update_topic_last_reply_at, on: [:create, :update]
    def update_topic_last_reply_at
      return if self.topic.blank?
      self.topic.replied_at = Time.now
      self.topic.last_active_mark = Time.now.to_i
      self.topic.last_reply_user_id = self.user_id
      self.topic.replies_count = self.topic.replies.count
      self.topic.save
    end
  end
end
