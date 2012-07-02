# coding: utf-8
module Homeland
  class Topic
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paranoia

    field :title
    field :body
    field :replied_at , :type => DateTime
    field :replies_count, :type => Integer, :default => 0

    belongs_to :user, :inverse_of => :topics, :class_name => Homeland.user_class.to_s
    belongs_to :node, :class_name => "Homeland::Node"
    belongs_to :last_reply_user, :class_name => Homeland.user_class.to_s
    has_many :replies, :class_name => "Homeland::Reply"

    attr_protected :user_id
    validates_presence_of :user_id, :title, :body, :node_id

    index :replied_at => -1
    index :user_id => 1
    index :node_id => 1

    # scopes
    scope :last_actived, desc(:replied_at).desc(:_id)
    scope :recent, desc(:_id)
    before_save :set_replied_at
    def set_replied_at
      self.replied_at = Time.now
    end

    def node_name
      return "" if self.node.blank?
      self.node.name
    end
  end
end