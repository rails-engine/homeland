# coding: utf-8  
module Homeland
  class ApplicationController < ActionController::Base
    protect_from_forgery  
    
    layout :choose_layout
    
    private
    def choose_layout
      Rails.configuration.homeland.layout
    end
  end
end
