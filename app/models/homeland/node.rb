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
  end
end