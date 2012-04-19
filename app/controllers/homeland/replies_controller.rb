# coding: utf-8
module Homeland
  class RepliesController < Homeland::ApplicationController
    before_filter :homeland_require_user
  
    def edit
      @reply = current_user.replies.find(params[:id])
    end
  
    def update
      @reply = current_user.replies.find(params[:id])

      if @reply.update_attributes(params[:reply])
        redirect_to(topic_path(@reply.topic_id,:anchor => "reply#{@reply.topic.replies_count}"), :notice => '回帖更新成功.')
      else
        render :action => "edit"
      end
    end
  end
end