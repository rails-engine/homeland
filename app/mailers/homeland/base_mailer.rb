# coding: utf-8  
module Homeland
  class BaseMailer < ActionMailer::Base
    layout 'mailer'
    helper :topics
  end
end