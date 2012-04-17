# coding: utf-8  
module Homeland
  class TopicsController < Homeland::ApplicationController
    before_filter :homeland_require_user, :only => [:new,:edit,:create,:update,:destroy,:reply]
    before_filter :init_list_sidebar, :only => [:index,:recent,:show,:cate,:search]
    caches_page :feed, :expires_in => 1.hours

    private
    def init_list_sidebar 
     if !fragment_exist? "topic/init_list_sidebar/hot_nodes"
        @hot_nodes = Node.hots.limit(20)
      end
    end

    public
    # GET /topics
    # GET /topics.xml
    def index
      @topics = Topic.last_actived.limit(10)
      @sections = Section.all

    end
  
    def feed
      @topics = Topic.recent.limit(20)
      response.headers['Content-Type'] = 'application/rss+xml'
      render :layout => false
    end

    def node
      @node = Node.find(params[:id])
      @topics = @node.topics.last_actived.paginate(:page => params[:page],:per_page => 50)

      render :action => "index"
    end

    def recent
      @topics = Topic.recent.limit(50)

      render :action => "index"
    end

    def search
      result = Redis::Search.query("Topic", params[:key], :limit => 500)
      ids = result.collect { |r| r["id"] }
      @topics = Topic.find(ids).paginate(:page => params[:page], :per_page => 20)
      
      render :action => "index"
    end

    def show
      @topic = Topic.find(params[:id])
      @topic.hit!
      @node = @topic.node
      @replies = @topic.replies.all

    end

    # GET /topics/new
    # GET /topics/new.xml
    def new
      @topic = Topic.new
      @topic.node_id = params[:node]
      @node = Node.find(params[:node])
    end

    def reply
      @topic = Topic.find(params[:id])
      @reply = @topic.replies.build(params[:reply])        
      @reply.user_id = current_user.id
      if @reply.save
        flash[:notice] = "回复成功。"
      else
        flash[:notice] = @reply.errors.full_messages.join("<br />")
      end
      redirect_to topic_path(params[:id],:anchor => 'reply')
    end

    # GET /topics/1/edit
    def edit
      @topic = current_user.topics.find(params[:id])
      @node = @topic.node
    end

    # POST /topics
    # POST /topics.xml
    def create
      pt = params[:topic]
      @topic = Topic.new(pt)
      @topic.user_id = current_user.id
      @topic.node_id = params[:node] || pt[:node_id]

      if @topic.save
        redirect_to(topic_path(@topic.id), :notice => '帖子创建成功.')
      else
        render :action => "new"
      end
    end

    # PUT /topics/1
    # PUT /topics/1.xml
    def update
      @topic = current_user.topics.find(params[:id])
      pt = params[:topic]
      @topic.node_id = pt[:node_id]
      @topic.title = pt[:title]
      @topic.body = pt[:body]

      if @topic.save
        redirect_to(topic_path(@topic.id), :notice => '帖子修改成功.')
      else
        render :action => "edit"
      end
    end

    # DELETE /topics/1
    # DELETE /topics/1.xml
    def destroy
      @topic = current_user.topics.find(params[:id])
      @topic.destroy
      redirect_to(topics_path, :notice => '帖子删除成功.')
    end
  end
end
