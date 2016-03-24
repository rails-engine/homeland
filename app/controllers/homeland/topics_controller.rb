module Homeland
  class TopicsController < Homeland::ApplicationController
    before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :reply]
    before_action only: [:edit, :update, :destroy] do
      authorize_resource! topic
    end

    def index
      @topics = Topic.latest.includes(:user).page(params[:page])

      set_seo_meta(t("homeland.nav.latest"))
    end

    def node
      @node = Node.find(params[:id])
      @topics = @node.topics.latest.includes(:user).page(params[:page])

      render action: "index"
    end

    %w(recent features).each do |action|
      define_method(action) do
        @topics = Topic.send(action).includes(:user, :node).page(params[:page])

        set_seo_meta(t("homeland.nav.#{action}"))

        render action: "index"
      end
    end

    def show
      @topic = Topic.find(params[:id])
      @replies = replies

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
        flash[:notice] = t('homeland.reply_created')
      else
        flash[:alert] = @reply.errors.full_messages.join("<br />")
      end
      redirect_to topic_path(params[:id],:anchor => "reply")
    end

    # GET /topics/1/edit
    def edit
      @node = @topic.node
    end

    # POST /topics
    # POST /topics.xml
    def create
      @topic = Topic.new(topic_params)
      @topic.user_id = current_user.id

      if @topic.save
        redirect_to(topic_path(@topic.id), notice: t('homeland.topic_created'))
      else
        render action: "new"
      end
    end

    # PUT /topics/1
    # PUT /topics/1.xml
    def update
      @topic = Topic.find(params[:id])

      if @topic.update_attributes(topic_params)
        redirect_to(topic_path(@topic.id), notice: t('homeland.topic_updated'))
      else
        render action: "edit"
      end
    end

    # DELETE /topics/1
    # DELETE /topics/1.xml
    def destroy
      topic.destroy
      redirect_to(topics_path, notice: t('homeland.topic_deleted'))
    end

    private

    def topic
      @topic ||= Topic.find(params[:id])
    end

    def replies
      @topic.replies.includes(:user).page(params[:page])
    end

    def topic_params
      params.require(:topic).permit(:node_id, :title, :body)
    end

    def reply_params
      params.require(:reply).permit(:body, :reply_to_id)
    end
  end
end
