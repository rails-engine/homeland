require "homeland/engine"
require 'homeland/configuration'
require 'homeland/markup'

module Homeland
  class << self
    def config
      return @config if defined?(@config)
      @config = Configuration.new
      @config.user_class = 'User'
      @config.authenticate_user_method = 'authenticate_user!'
      @config.current_user_method = 'current_user'
      @config
    end

    def configure(&block)
      config.instance_exec(&block)
    end
  end
end
