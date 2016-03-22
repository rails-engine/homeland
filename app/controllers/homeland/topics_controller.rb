# coding: utf-8
module Homeland
  class TopicsController < Homeland::ApplicationController
    before_filter :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :reply]

    def index
      @topics = Topic.latest.includes(:user).limit(10)

      set_seo_meta(t("homeland.nav.latest"))
    end

    def node
      @node = Node.find(params[:id])
      @topics = @node.topics.latest.includes(:user).limit(50)

      render action: "index"
    end

    %w(recent features).each do |action|
      define_method(action) do
        @topics = Topic.send(action).includes(:user, :node).limit(20)

        set_seo_meta(t("homeland.nav.#{action}"))

        render action: "index"
      end
    end

    def show
      @topic = Topic.find(params[:id])
      @replies = @topic.replies.includes(:user)

      set_seo_meta(@topic.title)
    end

    def new
      @topic = Topic.new
      @node = Node.find_by(id: params[:node_id])

      set_seo_meta(t("homeland.nav.new"))
    end

    def reply
      @topic = Topic.find(params[:id])
      @reply = @topic.replies.build(reply_params)
      @reply.user_id = current_user.id
      if @reply.save
        flash[:alert_reply] = "回复成功。"
      else
        flash[:alert_reply] = @reply.errors.full_messages.join("<br />")
      end
      redirect_to topic_path(params[:id],:anchor => "reply")
    end

    # GET /topics/1/edit
    def edit
      @topic = Topic.where(user_id: current_user.id).find(params[:id])
      @node = @topic.node
    end

    # POST /topics
    # POST /topics.xml
    def create
      @topic = Topic.new(topic_params)
      @topic.user_id = current_user.id

      if @topic.save
        redirect_to(topic_path(@topic.id), notice: '帖子创建成功.')
      else
        render action: "new"
      end
    end

    # PUT /topics/1
    # PUT /topics/1.xml
    def update
      @topic = Topic.where(user_id: current_user.id).find(params[:id])

      if @topic.update_attributes(topic_params)
        redirect_to(topic_path(@topic.id), notice: '帖子修改成功.')
      else
        render action: "edit"
      end
    end

    # DELETE /topics/1
    # DELETE /topics/1.xml
    def destroy
      @topic = Topic.where(user_id: current_user.id).find(params[:id])
      @topic.destroy
      redirect_to(topics_path, notice: '帖子删除成功.')
    end

    private

    def topic_params
      params.require(:topic).permit(:node_id, :title, :body)
    end

    def reply_params
      params.require(:reply).permit(:body)
    end
  end
end
