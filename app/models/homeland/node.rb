module Homeland
  class Node < ActiveRecord::Base
    validates :name, :description, presence: true
    validates :name, uniqueness: true

    has_many :topics, class_name: 'Homeland::Topic'

    def badge_color
      self.color || '#AAA'
    end

    def badge_html
      %(<i class="node-badge" style="background: #{self.badge_color};"></i>)
    end
  end
end
