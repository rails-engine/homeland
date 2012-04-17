# coding: utf-8  
class Homeland::ApplicationController < ApplicationController
  helper_method :current_user
  
  alias_method :origin_current_user, Homeland.current_user_method.to_sym
  def current_user
    origin_current_user
  end
  
  def homeland_require_user
    self.send(Homeland.require_user_method)
  end
  
end
