require "homeland/version"
require "homeland/engine"
require 'homeland/configuration'
require 'homeland/markup'
require 'homeland/action_view/will_paginate'
require 'homeland/concerns/markup'
require 'homeland/concerns/soft_delete'
require 'homeland/concerns/user_delegates'
require 'will_paginate'
require 'will_paginate/active_record'
require 'font-awesome-rails'

module Homeland
  class << self
    attr_accessor :markups

    def config
      return @config if defined?(@config)
      @config = Configuration.new
      @config.markup = :markdown
      @config.app_name = 'Homeland'
      @config.per_page = 32
      @config.user_class = 'User'
      @config.user_name_method = 'name'
      @config.user_avatar_url_method = nil
      @config.user_admin_method = 'admin?'
      @config.user_profile_url_method = 'profile_url'
      @config.authenticate_user_method = 'authenticate_user!'
      @config.current_user_method = 'current_user'
      @config.node_colors = ['#0E76BD', '#CEA9A9', '#e9dd00', '#222', '#F7941D', '#AB9364', '#76923C', '#33b']
      @config
    end

    def configure(&block)
      config.instance_exec(&block)
    end

    def node_colors

    end
  end
end
