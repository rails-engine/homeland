# coding: utf-8  
module Homeland
  class Node
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name
    field :summary
    field :sort, :type => Integer, :default => 0
    field :topics_count, :type => Integer, :default => 0
  
    has_many :topics, :class_name => "Homeland::Topic"
    belongs_to :section, :class_name => "Homeland::Section"
  
    validates_presence_of :name, :summary
    validates_uniqueness_of :name
  
    index :topics_count
    index :sort

    scope :hots, desc(:topics_count)
    scope :sorted, desc(:sort)

    # 热门节电给 select 用的
    def self.node_collection
      Rails.cache.fetch("node:node_collection:#{CacheVersion.section_node_updated_at}") do
        Node.all.collect { |n| [n.name,n.id] }
      end
    end
  end
end