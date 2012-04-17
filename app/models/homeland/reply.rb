# coding: utf-8  
module Homeland
  class Reply
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paranoia

    field :body
  
    belongs_to :user, :inverse_of => :replies, :class_name => Homeland.user_class.to_s
    belongs_to :topic, :inverse_of => :replies, :class_name => "Homeland::Topic"
  
    attr_protected :user_id, :topic_id
  
    index :topic_id
    index :user_id

    validates_presence_of :body
    scope :recent, desc(:_id)
  
    after_create :update_parent_last_replied
    def update_parent_last_replied
      self.topic.replied_at = Time.now
      self.topic.last_reply_user_id = self.user_id
      self.topic.replies_count = self.topic.replies.count
      self.topic.save
    end
  end
end