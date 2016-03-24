require 'test_helper'

class TopicsTest < ActionDispatch::IntegrationTest
  setup do
    @current_user = create(:user)

    @session = sign_in_session(@current_user)
  end

  test 'GET /homeland/t' do
    topics = create_list(:topic, 4)
    get homeland.topics_path
    assert_response :success
    assert_select 'title', /Latest/
    assert_select 'div.topics' do
      assert_select 'table' do
        assert_select 'thead tr.topic', 1
        assert_select 'tbody tr.topic', 4
      end
    end
  end

  test 'GET /homeland/t/recent' do
    topics = create_list(:topic, 2)
    get homeland.recent_topics_path
    assert_response :success
    assert_select 'title', /Recent/
    assert_select 'div.topics' do
      assert_select 'table' do
        assert_select 'thead tr.topic', 1
        assert_select 'tbody tr.topic', 2
      end
    end
  end

  test 'GET /homeland/t/features' do
    topics = create_list(:topic, 2, replies_count: 20)
    create_list(:topic, 2)
    get homeland.features_topics_path
    assert_response :success
    assert_select 'title', /Features/
    assert_select 'div.topics' do
      assert_select 'table' do
        assert_select 'thead tr.topic', 1
        assert_select 'tbody tr.topic', 2
      end
    end
  end

  test 'GET /homeland/c/:id' do
    node = create(:node)
    topics = create_list(:topic, 2, node: node)
    other_topics = create_list(:topic, 2)
    get homeland.node_topics_path(node.id)
    assert_response :success
    assert_select '.card-title a.node .name', text: node.name
    assert_select 'div.topics' do
      assert_select 'table' do
        assert_select 'thead tr.topic', 1
        assert_select 'tbody tr.topic', 2
      end
    end
    assert_select 'tr.topic td.title a', text: topics[0].title
    assert_select 'tr.topic td.title a', text: topics[1].title
    assert_select 'tr.topic td.title a', text: other_topics[0].title, count: 0
    assert_select 'tr.topic td.title a', text: other_topics[1].title, count: 0
  end

  test 'GET /homeland/t/new' do
    get homeland.new_topic_path
    assert_response :redirect
    assert_redirected_to %r(/users/sign_in)
  end

  test 'GET /homeland/t/new with sign in' do
    sign_in @current_user
    get '/homeland/t/new'
    assert_response :success
    assert_select "li.active", "New"
    assert_select "form.new_topic" do
      assert_select 'div.form-group select[name=?]', 'topic[node_id]'
      assert_select 'div.form-group input[name=?]', 'topic[title]'
      assert_select 'div.form-group textarea[name=?]', 'topic[body]'
      assert_select 'div.form-group button[type="submit"]', 1
    end
  end

  test 'POST /homeland/t' do
    topic = build(:topic)
    params = {
      topic: {
        title: topic.title,
        body: topic.body,
        node_id: topic.node_id
      }
    }
    assert_no_difference "Homeland::Topic.count", +1 do
      post homeland.topics_path, params: params
      assert_redirected_to %r(/users/sign_in)
    end

    assert_difference 'topic.node.topics.count', +1 do
      sign_in @current_user
      post '/homeland/t', params: params
      assert_response :redirect
      follow_redirect!
      assert_select ".node .name", { text: topic.node.name }
      assert_select "title", { text: topic.title }
    end
  end

  test 'GET /homeland/t/:id' do
    topic = create(:topic, user: @current_user)
    replies = create_list(:reply, 4, topic: topic)
    get homeland.topic_path(topic)
    assert_response :success
    assert_select 'title', text: topic.title
    assert_select 'div.topic-detail' do
      assert_select 'div.reply', 5 do
        assert_select 'a.btn-opt[href=?]', homeland.edit_topic_path(topic), 0
      end
    end

    @session.get "/homeland/t/#{topic.id}"
    @session.assert_response :success
    @session.assert_select 'title', text: topic.title
    @session.assert_select 'a.btn-opt[href=?]', homeland.edit_topic_path(topic), 1
    @session.assert_select 'a.btn-opt[href=?]', homeland.topic_path(topic), 1 do |doc|
      assert_equal 'DELETE', doc.attr('data-method').value
    end
  end

  test 'GET /homeland/t/:id/edit' do
    topic = create(:topic, user: @current_user)

    get homeland.edit_topic_path(topic)
    assert_required_user

    user1 = create(:user)
    sign_in user1
    get "/homeland/t/#{topic.id}/edit"
    assert_access_denied
  end

  test 'GET /homeland/t/:id/edit with owner' do
    topic = create(:topic, user: @current_user)

    sign_in @current_user
    get "/homeland/t/#{topic.id}/edit"
    assert_response :success
    assert_select '.breadcrumb li.active', text: 'Edit'
    assert_select 'form.edit_topic'
  end

  test 'PUT /homeland/t/:id' do
    topic = create(:topic, user: @current_user)

    patch "/homeland/t/#{topic.id}", params: {}
    assert_required_user

    user1 = create(:user)
    sign_in user1
    patch "/homeland/t/#{topic.id}", params: {}
    assert_access_denied
  end

  test 'PUT /homeland/t/:id with correct user' do
    topic = create(:topic, user: @current_user)
    new_node = create(:node)
    params = {
      topic: {
        user_id: 1213,
        node_id: new_node.id,
        title: "The new title",
        body: "The new body"
      }
    }

    sign_in @current_user
    patch "/homeland/t/#{topic.id}", params: params
    assert_response :redirect, "/homeland/t/#{topic.id}"
    assert_equal 'Topic updated success.', flash[:notice]
    topic.reload
    assert_equal @current_user.id, topic.user_id
    assert_equal params[:topic][:node_id], topic.node_id
    assert_equal params[:topic][:title], topic.title
    assert_equal params[:topic][:body], topic.body
  end

  test 'POST /homeland/t/:id/reply' do
    topic = create(:topic)
    last_reply = create(:reply, topic: topic)
    params = {
      reply: {
        user_id: 1231,
        reply_to_id: last_reply.id,
        body: "Foo bar"
      }
    }
    post "/homeland/t/#{topic.id}/reply", params: params
    assert_required_user

    sign_in @current_user
    post "/homeland/t/#{topic.id}/reply", params: { reply: { body: '' } }
    assert_response :redirect, "/homeland/t/#{topic.id}"
    assert_equal "Content can't be blank", flash[:alert]

    assert_difference "topic.replies.count", +1 do
      post "/homeland/t/#{topic.id}/reply", params: params
      assert_response :redirect, "/homeland/t/#{topic.id}"
      assert_equal 'Reply created success.', flash[:notice]
      reply = topic.replies.last
      assert_equal @current_user.id, reply.user_id
      assert_equal last_reply.id, reply.reply_to_id
      assert_equal params[:reply][:body], reply.body
    end
  end

  test 'DELETE /homeland/t/:id' do
    topic = create(:topic)
    user1 = create(:user)

    delete "/homeland/t/#{topic.id}"
    assert_required_user

    sign_in user1
    delete "/homeland/t/#{topic.id}"
    assert_access_denied
  end

  test 'DELETE /homeland/t/:id with correct user' do
    topic = create(:topic)

    sign_in topic.user
    delete "/homeland/t/#{topic.id}"
    topic.reload
    assert_equal true, topic.deleted?
    assert_response :redirect, "/homeland/t/"
    assert_equal 'Topic deleted success.', flash[:notice]
  end
end
