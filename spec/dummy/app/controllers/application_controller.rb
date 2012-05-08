class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!

  def require_user
    if !current_user
      redirect_to new_session_path(:user)
      return false
    end
  end
end
