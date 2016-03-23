module Homeland
  class RepliesController < Homeland::ApplicationController
    before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :reply]
    before_action only: [:edit, :update, :destroy] do
      authorize_resource! reply
    end

    def edit
    end

    def update
      if reply.update_attributes(reply_params)
        redirect_to(topic_path(reply.topic_id, anchor: "reply-#{reply.id}"), notice: t('homeland.reply_updated'))
      else
        render action: "edit"
      end
    end

    def destroy
      reply.destroy
      redirect_to(topic_path(reply.topic_id), notice: t('homeland.reply_deleted'))
    end

    private

    def reply
      @reply ||= Reply.find(params[:id])
    end

    def reply_params
      params.require(:reply).permit(:body, :reply_to_id)
    end
  end
end
