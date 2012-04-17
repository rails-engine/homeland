# coding: utf-8
module ::Homeland
  class Engine < ::Rails::Engine
    isolate_namespace Homeland
    
    class << self
      attr_accessor :root
      def root
        @root ||= Pathname.new(File.expand_path('../../', __FILE__))
      end
    end
    
    config.to_prepare do
      if Homeland.user_class
        Homeland.user_class.has_many :topics, :class_name => "Homeland::Topic", :foreign_key => "user_id"
        Homeland.user_class.has_many :replies, :class_name => "Homeland::Reply", :foreign_key => "user_id"
      end
    end
  end
end


begin
  require 'kaminari'
rescue LoadError
  begin
    require 'will_paginate'
  rescue LoadError
   puts "Please add the kaminari or will_paginate gem to your application's Gemfile. The Forem engine needs either kaminari or will_paginate in order to paginate."
   exit
  end
end
