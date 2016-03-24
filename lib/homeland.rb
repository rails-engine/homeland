require "homeland/engine"
require 'homeland/configuration'
require 'homeland/markup'
require 'homeland/action_view/will_paginate'
require 'font-awesome-rails'

module Homeland
  class << self
    def config
      return @config if defined?(@config)
      @config = Configuration.new
      @config.app_name = 'Homeland'
      @config.per_page = 32
      @config.user_class = 'User'
      @config.user_name_method = 'name'
      @config.user_avatar_method = nil
      @config.user_admin_method = 'admin?'
      @config.user_profile_url_method = 'profile_url'
      @config.authenticate_user_method = 'authenticate_user!'
      @config.current_user_method = 'current_user'
      @config
    end

    def configure(&block)
      config.instance_exec(&block)
    end
  end
end
