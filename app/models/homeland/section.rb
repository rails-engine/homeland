# coding: utf-8  
module Homeland
  class Section
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name
    field :sort, :type => Integer, :default => 0
    has_many :nodes, :dependent => :destroy, :class_name => "Homeland::Node"
  
    validates_presence_of :name
    validates_uniqueness_of :name
  
  
    default_scope desc(:sort)

    def sorted_nodes
      self.nodes.sorted
    end
  end
end