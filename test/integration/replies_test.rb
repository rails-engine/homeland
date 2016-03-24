require 'test_helper'

class RepliesTest < ActionDispatch::IntegrationTest
  setup do
    @current_user = create(:user)
    @reply = create(:reply, user: @current_user)
  end

  test 'GET /homeland/r/:id/edit' do
    get homeland.edit_reply_path(@reply)
    assert_required_user
  end

  test 'GET /homeland/r/:id/edit without owner' do
    user = create(:user)
    sign_in user
    get "/homeland/r/#{@reply.id}/edit"
    assert_access_denied
  end

  test 'GET /homeland/r/:id/edit with owner' do
    sign_in @current_user
    get "/homeland/r/#{@reply.id}/edit"
    assert_response :success
    assert_select 'form.edit_reply' do
      assert_select 'textarea[name=?]', 'reply[body]'
    end
    assert_select '.breadcrumb li.active', text: 'Edit'
  end

  test 'PUT /homeland/r/:id' do
    put homeland.reply_path(@reply), params: { reply: { body: '' }}
    assert_required_user
  end

  test 'PUT /homeland/r/:id without owner' do
    user = create(:user)
    sign_in user
    put "/homeland/r/#{@reply.id}", params: { reply: { body: '' }}
    assert_access_denied
  end

  test 'PUT /homeland/r/:id with owner' do
    reply = create(:reply, user: @current_user)
    old_topic_id = reply.topic_id
    params = {
      reply: {
        body: 'New content',
        topic: 12349882,
        user_id: 887721
      }
    }
    sign_in @current_user
    put "/homeland/r/#{reply.id}", params: params
    assert_response :redirect, "/homeland/t/#{reply.topic_id}"
    assert_equal 'Reply updated success.', flash[:notice]
    reply.reload
    assert_equal 'New content', reply.body
    assert_equal old_topic_id, reply.topic_id
    assert_equal @current_user.id, reply.user_id
  end

  test 'DELETE /homeland/r/:id without owner' do
    delete "/homeland/r/#{@reply.id}"
    assert_required_user

    sign_in create(:user)
    delete "/homeland/r/#{@reply.id}"
    assert_access_denied
  end

  test 'DELETE /homeland/r/:id with owner' do
    reply = create(:reply, user: @current_user)
    sign_in @current_user
    delete "/homeland/r/#{reply.id}"
    assert_response :redirect, "/homeland/t/#{reply.topic_id}"
    assert_equal 'Reply deleted success.', flash[:notice]
    reply.reload
    assert_equal true, reply.deleted?
  end
end
